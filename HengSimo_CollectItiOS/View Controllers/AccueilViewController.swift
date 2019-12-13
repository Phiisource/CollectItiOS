//
//  FirstViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccueilViewController: UIViewController {

    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var pointsnb_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            
            username_label.text = user.email
            
        }  else {
            
            print("msg from Accueil : aucun utilisateur connecté")
            
        }
    }

}

