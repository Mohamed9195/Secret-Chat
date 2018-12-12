//
//  SignIn.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignIn: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var retPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressSubmit(_ sender: UIButton) {
        
       
        SVProgressHUD.show(withStatus: "loading")
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (use, error) in
            
                        if error != nil {
                             SVProgressHUD.dismiss()
                            let alert = UIAlertController(title: "Registeration", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            
                        }else{
                            
                            
                            let DataTODatabase: [String? : String? ] = ["name": self.name.text! , "password": self.password.text! , "email": self.email.text!]
                            let PErsonalData = Database.database().reference(withPath: "Personal Data").child("Data")
                            PErsonalData.child((Auth.auth().currentUser?.uid)!).setValue(DataTODatabase){
                                (error , refernce) in
                                if error != nil {
                                    SVProgressHUD.dismiss()
                                    let alert = UIAlertController(title: "Registeration", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }else{

                             
                                    SVProgressHUD.dismiss()
                                }
                            }
                            
                           
                            SVProgressHUD.displayDuration(for: "Wellcom")
                            self.performSegue(withIdentifier: "GoToPepleFromSignIn", sender: self)
                            
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

}
