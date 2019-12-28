//
//  AccountViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 12/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nom_textfield: UILabel!
    @IBOutlet weak var prenom_textfield: UILabel!
    @IBOutlet weak var dateinscription_textfield: UILabel!
    @IBOutlet weak var email_textfield: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Si un utilisateur est connecté
        if let user = Auth.auth().currentUser {
            
            // Récupérer les données du CoreData User
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            request.returnsObjectsAsFaults = false
            
            // Filtrer les données du CoreData User selon le userid, l'email utilisé dans firebase
            request.predicate = NSPredicate(format: "userid == %@", user.email!)
            
            do {
                
                if let results = try context.fetch(request) as? [User] {
                    
                    // Récupérer le user du CoreData User
                    let currentuser = results[0]
                    
                    // Afficher le prénom et nb de points de l'utilisateur (from CoreData User)
                    nom_textfield.text = currentuser.nom
                    prenom_textfield.text = currentuser.prenom
                    email_textfield.text = currentuser.userid
                    
                    if currentuser.dateinscription != nil {
                        // Formater la date pour l'utiliser en string
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                        let dateString = formatter.string(from: currentuser.dateinscription!)
                        let dateinscription = formatter.date(from: dateString)
                        formatter.dateFormat = "dd/MM/yyyy"
                        let dateStringFormat = formatter.string(from: dateinscription!)
                        
                        dateinscription_textfield.text = dateStringFormat
                    } else {
                        dateinscription_textfield.text = "Aucune donnée"
                    }
                }
                
            } catch {
                
                fatalError("Problème fetch user CoreData (AccueilVC)")
                
            }
            
        }
    }
    
    // Action quand le bouton Fermer est cliqué
    @IBAction func sendCloseButton(_ sender: UIBarButtonItem) {
        
        //Fermer la vue
        dismiss(animated: true, completion: nil)
    }
    
    // Action quand le bouton Déconnexion est cliqué
    @IBAction func senLogoutButton(_ sender: UIButton) {
        
        //Déconnecter l'utilisateur courrant connecté avec FireBase
        try! Auth.auth().signOut()
        
        //Fermer la vue
        dismiss(animated: true, completion: nil)
        
    }
}
