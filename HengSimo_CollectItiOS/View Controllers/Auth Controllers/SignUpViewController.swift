//
//  SignUpViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 10/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

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
        
        // Vérifier si tous les champs sont saisis et que le switcher admin est off
        if nom_textfield.text != "" && prenom_textfield.text != "" && emailaddress_textfield.text != "" && password_textfield.text != "" && passwordconfirm_textfield.text != "" && isadmin_switcher.isOn == false {
            
            // Vérifier si les mots de passe correspondent
            if password_textfield.text == passwordconfirm_textfield.text {
                
                // Créer un nouvel utilisateur sur FireBase
                Auth.auth().createUser(withEmail: emailaddress_textfield.text!, password: password_textfield.text!) { (authResult, error) in
                    
                    if error != nil {
                        
                        // S'il y a une erreur dans l'inscription FireBase, l'afficher
                        print(error.debugDescription)
                        
                        // Et afficher une popup d'erreur
                        let alertController = UIAlertController(title: "Alerte", message:
                            "L'inscription n'a pas pu être réalisée", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        
                        // S'il n'y a pas d'erreur dans l'inscription FireBase, créer en plus une instance CoreData pour enregistrer le nom, prénom, nb de points de l'utilisateur
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                        
                        newUser.setValue(self.emailaddress_textfield.text!.lowercased(), forKey: "userid")
                        newUser.setValue(self.nom_textfield.text, forKey: "nom")
                        newUser.setValue(self.prenom_textfield.text, forKey: "prenom")
                        newUser.setValue(Date(), forKey: "dateinscription")
                        
                        do {
                            
                            //Enregistrer ce nouvel user au CoreData User
                            try context.save()
                            print("***************** AJOUT USER FAIT *****************")
                                
                            //Fermer la fenêtre
                            self.dismiss(animated: true, completion: nil)
                            
                        } catch {
                            
                            // Afficher un message d'erreur sur la sauvegarde CoreData
                            let alertController = UIAlertController(title: "Alerte", message:
                                "Problème CoreData (signup)", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default))
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                // Si les mots de passe ne correspondent pas, afficher une popup d'erreur
                let alertController = UIAlertController(title: "Alerte", message:
                    "Les mots de passe ne correspondent pas", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }
        
        /*// Sinon, vérifier si tous les champs sont saisis et que le switcher admin est actif, ainsi que le champs mdp admin est saisi
        else if nom_textfield.text != "" && prenom_textfield.text != "" && emailaddress_textfield.text != "" && password_textfield.text != "" && passwordconfirm_textfield.text != "" && isadmin_switcher.isOn == true && adminpassword_textfield.text != "" {
            
            if adminpassword_textfield.text == "motdepasse" {
                
            }
            
            dismiss(animated: true, completion: nil)
            
        }*/
            
        // Sinon, si l'utilisateur a sélectionné admin (sans vérification du mot de passe)
        else if nom_textfield.text != "" && prenom_textfield.text != "" && emailaddress_textfield.text != "" && password_textfield.text != "" && passwordconfirm_textfield.text != "" && isadmin_switcher.isOn == true {
            
            Auth.auth().createUser(withEmail: emailaddress_textfield.text!, password: password_textfield.text!) { (authResult, error) in
                
                if error != nil {
                    
                    // S'il y a une erreur dans l'inscription FireBase, l'afficher
                    print(error.debugDescription)
                    
                    // Et afficher une popup d'erreur
                    let alertController = UIAlertController(title: "Alerte", message:
                        "L'inscription n'a pas pu être réalisée", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    // S'il n'y a pas d'erreur dans l'inscription FireBase, créer en plus une instance CoreData pour enregistrer le nom, prénom, nb de points de l'utilisateur
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                    
                    newUser.setValue(self.emailaddress_textfield.text!.lowercased(), forKey: "userid")
                    newUser.setValue(self.nom_textfield.text, forKey: "nom")
                    newUser.setValue(self.prenom_textfield.text, forKey: "prenom")
                    newUser.setValue(true, forKey: "isAdmin")
                    newUser.setValue(Date(), forKey: "dateinscription")
                    
                    do {
                        
                        //Enregistrer ce nouvel user au CoreData User
                        try context.save()
                        print("***************** AJOUT ADMIN FAIT *****************")
                            
                        //Fermer la fenêtre
                        self.dismiss(animated: true, completion: nil)
                        
                    } catch {
                        
                        // Afficher un message d'erreur sur la sauvegarde CoreData
                        let alertController = UIAlertController(title: "Alerte", message:
                            "Problème CoreData (signup admin)", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
        }
        
        else {
            
            // Sinon, un des champs est vide
            // Afficher une popup d'erreur
            let alertController = UIAlertController(title: "Alerte", message:
                "Veuillez remplir tous les champs requis", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // Fermer la vue quand le bouton fermer est cliqué
    @IBAction func closeSignUpView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
