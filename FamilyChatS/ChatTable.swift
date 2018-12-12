//
//  ChatTable.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase


class ChatTable: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate{
 
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightSend: NSLayoutConstraint!
    
    var messageArray: [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)

        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextField.delegate = self
        // Do any additional setup after loading the view.
        
      
        messageTableView.register(UINib(nibName: "Sender", bundle: nil), forCellReuseIdentifier: "Sender")
       
        messageTableView.rowHeight = UITableView.automaticDimension
        configureTableView()
        retriveMessage()
        messageTableView.separatorStyle = .none
       messageTableView.rowHeight = UITableView.automaticDimension
        
    }

   


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = messageTableView.dequeueReusableCell(withIdentifier: "Sender", for: indexPath) as! Sender
        Cell.senderS.text = messageArray[indexPath.row].senderEmail
        Cell.messageS.text = messageArray[indexPath.row].messageBody
        if Auth.auth().currentUser?.email == messageArray[indexPath.row].senderEmail{
            Cell.photo.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.5725490196, alpha: 1)
            Cell.photo.layer.cornerRadius = 10
        }else
        {
            Cell.photo.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8431372549, blue: 1, alpha: 1)
        }
        
        
        
        return Cell
    }

    
    //TODO: Declare tableViewTapped here:  to dissmis any text view
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
   
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.viewHeight.constant = 360
//            self.view.layoutIfNeeded()
//        }
//    }
//
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 150
        messageTableView.rowHeight = UITableView.automaticDimension
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.viewHeight.constant = 50
//            self.view.layoutIfNeeded()
//        }
//    }

    
    @IBAction func sendMessages(_ sender: UIButton) {
        
        messageTextField.endEditing(true)
       messageTextField.isEnabled = false
        
        let messageData = ["message": messageTextField.text! , "sender": Auth.auth().currentUser?.email , "messageID" : Auth.auth().currentUser?.uid]
        
        
        Database.database().reference().child("user/message").childByAutoId().setValue(messageData){ (error , refrence) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            }else{
                print("goog save")
                self.messageTextField.isEnabled = true
                self.messageTextField.text = ""
            }
            
        }
        
    }
  
    // MARK: - update table when nwe data put
    
    func retriveMessage(){
        
        _ = Database.database().reference().child("user/message").observe( .childAdded , with:  { (DataSnapshot) in
            
                let dataAdded = DataSnapshot.value as! Dictionary<String , String>
        
                let text = dataAdded["message"]!
                let sender = dataAdded["sender"]!
        
                let messagee = Message()
                messagee.messageBody = text
                messagee.senderEmail = sender
        
                self.messageArray.append(messagee)
        
              self.configureTableView()
                self.messageTableView.reloadData()
          
        
            
            
        })
        
    }

}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
