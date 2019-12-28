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
    
    @IBOutlet var lots_tableview: UITableView!
    @IBOutlet weak var switchBO_button: UIButton!
    
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
                    
                    if currentuser.isAdmin {
                        
                        switchBO_button.isHidden = false
                        
                    }
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (AccueilVC)")
                
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lot")
        
        var nbLots = 0
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            nbLots = results.count
            
        } catch {
            
            print(error)
            
        }
        
        return nbLots
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LotTableViewCell.reuseIdentifier, for: indexPath) as? LotTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lot")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            // Récupérer les lots
            let results = try context.fetch(request)
            let oneLot = results[indexPath.row] as! Lot
            
            // Placer les données du CoreData Lots dans les cellules de la  table view
            cell.descriptionlot_label.text = oneLot.descriptionlot
            cell.coutlot_label.text = "Coût : \(String(oneLot.cout)) points"
            
            // Formater la date pour l'utiliser en string
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateString = formatter.string(from: oneLot.datevalidite!)
            let datevalidite = formatter.date(from: dateString)
            formatter.dateFormat = "dd/MM/yyyy"
            let dateStringFormat = formatter.string(from: datevalidite!)

            cell.datevalidite_label.text = "Valable jusqu'au \(dateStringFormat)"
            
        } catch {
            
            print(error)
            
        }

        return cell
    }
    
    // Rafraîchir les données de la liste des lots à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
