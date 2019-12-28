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
        
        // Vérifier si un utilisateur est connecté
        let user = Auth.auth().currentUser
        if user == nil {
            
            // Si aucun utilisateur est connecté, afficher le storyboard d'authentification
            performSegue(withIdentifier: "goToAuth", sender: self)
            
        } else {
            
            // Sinon, un message d'alerte s'affiche
            /*let alertController = UIAlertController(title: "Alerte", message:
                "Un utilisateur est déjà connecté", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)*/
            
        }
    }

}
