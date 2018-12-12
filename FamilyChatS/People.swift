//
//  People.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class People: UIViewController  ,UITableViewDelegate , UITableViewDataSource{
   
   
    var t = ["1" , "2", "3", "4"]
  
      var messageArray : [Message] = [Message]()
  
    
    
    @IBOutlet weak var tablePeople: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        tablePeople.dataSource =  self
        tablePeople.delegate = self
       
         tablePeople.register(UINib(nibName: "PeopleChat", bundle: nil), forCellReuseIdentifier: "PeopleChat")
        
        tablePeople.separatorStyle = .none
        retriveMessages()
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      

        return messageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let Cell = tablePeople.dequeueReusableCell(withIdentifier: "PeopleChat", for: indexPath) as! PeopleChat
        Cell.photo.image = UIImage(named: t[indexPath.row])

       Cell.name.text = messageArray[indexPath.row].senderName

        return Cell
        
    }
  
    func retriveMessages() {
        
        let messageDB = Database.database().reference().child("Personal Data").child("Data")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String , String>
            
            let text = snapshotValue["name"]!
           
            
            let message = Message()
            message.senderName = text
          
            
            // Array of Database
            self.messageArray.append(message)
            
         
            self.tablePeople.reloadData()
            
        })
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
           // GIDSignIn.sharedInstance()?.signOut()
            navigationController?.popViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
