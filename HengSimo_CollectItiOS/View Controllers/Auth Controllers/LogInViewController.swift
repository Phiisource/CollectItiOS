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
    
    @IBAction func sendConnexion_Button(_ sender: UIButton) {
        if emailaddress_textfield.text != "" && password_textfield.text != "" {
            
            Auth.auth().signIn(withEmail: emailaddress_textfield.text!, password: password_textfield.text!) {
                (authResult, error) in
                if error != nil {
                    
                    print (error.debugDescription)
                    
                } else {
    
                    print ("connexion de \(String(describing: self.emailaddress_textfield.text!))")
                    
                    self.performSegue(withIdentifier: "goToContent", sender: self)
                    
                }
            }
            
        } else {
            
            print ("un des champs n'est pas rempli")
            
        }
    }
}
