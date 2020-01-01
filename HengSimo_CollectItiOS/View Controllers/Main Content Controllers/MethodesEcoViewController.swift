//
//  SecondViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class MethodesEcoViewController: UIViewController {
    
    @IBOutlet weak var switchBO_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentUser()
    }
    
    fileprivate func fetchCurrentUser() {
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
                    
                    if currentuser.isAdmin {
                        
                        switchBO_button.isHidden = false
                        
                    } else {
                        
                        switchBO_button.isHidden = true
                        
                    }
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (AccueilVC)")
                
            }
        }
    }
}

