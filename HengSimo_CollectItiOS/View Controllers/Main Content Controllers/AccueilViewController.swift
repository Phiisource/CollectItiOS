//
//  FirstViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class AccueilViewController: UIViewController {
    
    var currentUser = User()

    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var pointsnb_label: UILabel!
    @IBOutlet weak var switchBO_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                if let results = try context.fetch(request) as? [User], results.count > 0 {

                    // Récupérer le user du CoreData User
                    currentUser = results[0]

                    // Afficher le prénom et nb de points de l'utilisateur (from CoreData User)
                    username_label.text = "\(currentUser.prenom!),"
                    pointsnb_label.text = "\(String(currentUser.nbpoints)) point(s)"

                    if currentUser.isAdmin {
                       
                       switchBO_button.isHidden = false
                       
                    }
                }
            } catch {
               
                fatalError("Problème fetch user CoreData (AccueilVC)")
               
            }
           
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentUser()
    }
}

