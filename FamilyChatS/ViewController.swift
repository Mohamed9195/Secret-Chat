//
//  ViewController.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit
import Firebase



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       // let ref: DatabaseReference!
        
//        ref = Database.database().reference()
//        ref.child("u/\(Auth.auth().currentUser?.uid)/username").childByAutoId().setValue("Mohamedbvbhhhh")
//
        if Auth.auth().currentUser?.uid != nil {
            performSegue(withIdentifier: "GoToPeople", sender: self)
        }
        
//        ref.child("u/\(Auth.auth().currentUser?.uid)/username").observeSingleEvent(of: .value, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            print(postDict)
//        })
        
        // Do any additional setup after loading the view, typically from a nib.
//        let storage = Storage.storage()
//        var data = Data()
//        data = UIImage(named: "1")!.pngData()! // image file name
//        // Create a storage reference from our storage service
//        let storageRef = storage.reference()
//        var imageRef = storageRef.child("images/lock.png")
//        _ = imageRef.putData(data, metadata: nil, completion: { (metadata,error ) in
//            guard let metadata = metadata else{
//                print(error)
//                return
//            }
//    
//            
//        })
    }


}

