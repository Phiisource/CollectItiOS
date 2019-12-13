//
//  ContentTabBarViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 11/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth

class ContentTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let user = Auth.auth().currentUser
        
        if user == nil {
            
            print("msg from contenttabbar : aucun utilisateur connecté")
            performSegue(withIdentifier: "goToAuth", sender: self)
            
        } else {
            
            print ("user currently logged in \(String(describing: Auth.auth().currentUser?.email!))")
            
        }
    }

}
