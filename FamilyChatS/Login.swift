//
//  Login.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class Login: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passowrd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressLogin(_ sender: UIButton) {
        
        SVProgressHUD.show(withStatus: "loading")
        
        Auth.auth().signIn(withEmail: email.text!, password: passowrd.text!) { (user, error) in
            
            if error != nil {
                
                SVProgressHUD.dismiss()
                //  SVProgressHUD.displayDuration(for: error!.localizedDescription)
                let alert = UIAlertController(title: "Login", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "GoToPepleFromJoin", sender: self)
            }
            
            
            
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
    
  
//
//    func retriveMessages() -> [String]{
//
//        //RETRIVEONEDATA: - from firebase
//        //        let userID = Auth.auth().currentUser?.uid
//        //                Database.database().reference().child("Personal                 Data").child("Data").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//        //                    // Get user value
//        //                    let value = snapshot.value as! Dictionary<String , String>
//        //                    print(value)
//        //                    // ...
//        //                }) { (error) in
//        //                    print(error.localizedDescription)
//        //                }
//
//        let n = Message()
//        //RETRIVEALLDATA: - from firebase
//        let allPlaces = Database.database().reference().child("Personal Data").child("Data")
//
//        allPlaces.observeSingleEvent(of: .value, with: { snapshot in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//                let placeDict = snap.value as! Dictionary<String , String>
//                let name = placeDict["name"]!
//             //   self.n.DataArray.append(name)//
//                // let info = placeDict["info"] as! String
//                //let moreInfo = placeDict["moreinfo"] as! String
//               // print(self.n.DataArray)
//            }
//        })
//        //return n.DataArray
//    }
}
