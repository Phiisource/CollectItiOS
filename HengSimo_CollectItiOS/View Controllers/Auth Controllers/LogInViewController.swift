//
//  LogInViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 10/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailaddress_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    @IBOutlet weak var login_button: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Action quand le bouton Connexion est cliqué
    @IBAction func sendConnexion_Button(_ sender: UIButton) {
        
        // Vérifier si les champs adresse email et mot de passe sont saisis
        if emailaddress_textfield.text != "" && password_textfield.text != "" {
            
            // Connecter un utilisateur avec FireBase
            Auth.auth().signIn(withEmail: emailaddress_textfield.text!, password: password_textfield.text!) {
                (authResult, error) in
                if error != nil {
                    
                    // S'il y a une erreur, print l'erreur
                    print(error.debugDescription)

                    // Et afficher une popup d'erreur
                    let alertController = UIAlertController(title: "Alerte", message:
                        "L'adresse email ou le mot de passe n'est pas valide", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    // S'il n'y a pas d'erreur, afficher le storyboard du contenu de l'app
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
            
        } else {
            
            // Sinon, afficher une popup d'erreur sur le contenu saisi lors de la connexion
            let alertController = UIAlertController(title: "Alerte", message:
                "Veuillez remplir les champs email et mot de passe", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}
