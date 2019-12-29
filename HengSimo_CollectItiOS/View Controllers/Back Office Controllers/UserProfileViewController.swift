//
//  UserProfileViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class UserProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var email_label: UILabel!
    @IBOutlet weak var nom_label: UILabel!
    @IBOutlet weak var prenom_label: UILabel!
    @IBOutlet weak var nbpoints_label: UILabel!
    
    @IBOutlet weak var modifiernbpoints_button: UIButton!
    @IBOutlet weak var validernbpoints_button: UIButton!
    
    @IBOutlet weak var nbpoints_textfield: UITextField!
    @IBOutlet weak var ajouterpoints_textfield: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        email_label.text = user?.userid
        nom_label.text = user?.nom
        prenom_label.text = user?.prenom
        nbpoints_label.text = String(user!.nbpoints)
        nbpoints_textfield.text = String(user!.nbpoints)
    }
    
    @IBAction func donnerpoints_button(_ sender: UIButton) {
        if checkTextField(text: ajouterpoints_textfield.text!) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.returnsObjectsAsFaults = false
            
            fetchRequest.predicate = NSPredicate(format: "userid == %@", user!.userid!)
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count != 0{

                    let managedObject = results[0] as! User
                    
                    managedObject.setValue(managedObject.nbpoints + Int64(ajouterpoints_textfield.text!)!, forKey: "nbpoints")

                    try context.save()
                    
                    nbpoints_label.text = String(managedObject.nbpoints)
                    nbpoints_textfield.text = String(managedObject.nbpoints)
                    
                    // Afficher un message de succès de la suppression des lots
                    displayAlertController(alertTitle: "Succès", alertMessage: "L'attribution des points a bien été effectuée", actionTitle: "OK")
                    
                    ajouterpoints_textfield.text = ""
                }
                
            } catch {
                
                // Afficher un message d'erreur sur l'échec de la suppression des lots
                displayAlertController(alertTitle: "Échec", alertMessage: "L'attribution des points à cet utilisateur n'a pas pu s'effectuer", actionTitle: "OK")
                
            }
        }
    }
    
    @IBAction func sendModifierNbPointsButton(_ sender: UIButton) {
        displayModifierNbPoints(bool: true)
    }
    
    fileprivate func checkTextField(text:String) -> Bool {
        if text != "" && text.isNumber {
            
            return true
            
        } else {
            
            displayAlertController(alertTitle: "Échec", alertMessage: "Veuillez saisir un nombre", actionTitle: "OK")
            return false
            
        }
    }
    
    fileprivate func displayAlertController(alertTitle:String, alertMessage:String, actionTitle:String) {
        
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func displayModifierNbPoints(bool:Bool) {
        nbpoints_label.isHidden = bool
        modifiernbpoints_button.isHidden = bool
        nbpoints_textfield.isHidden = !bool
        validernbpoints_button.isHidden = !bool
    }
    
    @IBAction func sendValiderNbPointsButton(_ sender: UIButton) {
        if checkTextField(text: nbpoints_textfield.text!) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.returnsObjectsAsFaults = false
            
            fetchRequest.predicate = NSPredicate(format: "userid == %@", user!.userid!)
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count != 0{

                    let managedObject = results[0] as! User
                    
                    managedObject.setValue(Int64(nbpoints_textfield.text!), forKey: "nbpoints")

                    try context.save()
                    
                    nbpoints_label.text = String(managedObject.nbpoints)
                    nbpoints_textfield.text = String(managedObject.nbpoints)
                    
                    // Afficher un message de succès de la suppression des lots
                    displayAlertController(alertTitle: "Succès", alertMessage: "L'attribution des points a bien été effectuée", actionTitle: "OK")
                    
                    displayModifierNbPoints(bool: false)
                }
                
            } catch {
                
                // Afficher un message d'erreur sur l'échec de la suppression des lots
                displayAlertController(alertTitle: "Échec", alertMessage: "L'attribution des points à cet utilisateur n'a pas pu s'effectuer", actionTitle: "OK")
                
            }
        }
    }
    
    @IBAction func sendDeleteUser(_ sender: RoundButton) {
        /*dismiss(animated: true, completion: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.predicate = NSPredicate(format: "userid == %@", user!.userid!)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count != 0{

                let managedObject = results[0] as! User
                
                context.delete(managedObject)

                try context.save()
            }
            
        } catch {
            
            // Afficher un message d'erreur sur l'échec de la suppression des lots
            displayAlertController(alertTitle: "Échec", alertMessage: "L'attribution des points à cet utilisateur n'a pas pu s'effectuer", actionTitle: "OK")
            
        }*/
    }
    
}

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
