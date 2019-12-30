//
//  LotsTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class LotsTableViewController: UITableViewController {
    
    var lots = [Lot]()
    
    @IBOutlet var lots_tableview: UITableView!
    @IBOutlet weak var switchBO_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUser()
        fetchLots()
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
                        
                    }
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (AccueilVC)")
                
            }
        }
    }
    
    fileprivate func fetchLots() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lot")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            // Récupérer les lots du CoreData
            let results = try context.fetch(request)
            guard let lots = results as? [Lot] else { return }
            self.lots = lots
            self.tableView.reloadData()
            
        } catch {
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LotTableViewCell.reuseIdentifier, for: indexPath) as? LotTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        cell.lot = lots[indexPath.row]

        return cell
    }
    
    // Rafraîchir les données de la liste des lots à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
