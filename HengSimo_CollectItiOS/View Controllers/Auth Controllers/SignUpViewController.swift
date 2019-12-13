//
//  SignUpViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 10/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var nom_textfield: UITextField!
    @IBOutlet weak var prenom_textfield: UITextField!
    @IBOutlet weak var emailaddress_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    @IBOutlet weak var passwordconfirm_textfield: UITextField!
    @IBOutlet weak var isadmin_switcher: UISwitch!
    @IBOutlet weak var adminpassword_textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendSignUp_Button(_ sender: RoundButton) {
        
        if nom_textfield.text != "" && prenom_textfield.text != "" && emailaddress_textfield.text != "" && password_textfield.text != "" && passwordconfirm_textfield.text != "" && isadmin_switcher.isOn == false {
            
            if password_textfield.text == passwordconfirm_textfield.text {
                
                Auth.auth().createUser(withEmail: emailaddress_textfield.text!, password: password_textfield.text!) { (authResult, error) in
                    
                    if error != nil {
                        print(error.debugDescription)
                    } else {
                        
                    }
                    
                }
                
            print ("inscription de \(String(describing: emailaddress_textfield.text!))")
                
            dismiss(animated: true, completion: nil)
                
            } else {
                
                print ("passwords aren't matching")
                
            }
            
        } else if isadmin_switcher.isOn == true && adminpassword_textfield.text != "" {
            
            print ("inscription de admin \(String(describing: emailaddress_textfield.text!))")
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
            print ("un des champs n'est pas rempli")
            
        }
    }
    
    @IBAction func closeSignUpView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
