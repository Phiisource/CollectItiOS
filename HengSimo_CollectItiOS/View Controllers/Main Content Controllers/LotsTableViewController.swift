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
    
    var currentUser = User()
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
                    currentUser = results[0]
                    
                    if currentUser.isAdmin {
                        
                        switchBO_button.isHidden = false
                        
                    }
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (LotsTableView)")
                
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
        fetchLots()
        tableView.reloadData()
    }
    
    @IBAction func sendObtenirLot_button(_ sender: RoundButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let tbl = cell.superview as! UITableView
        let indexPath = tbl.indexPath(for: cell)
        let selectedLot = lots[indexPath!.row] as Lot
        
        let alert = UIAlertController(title: "Confirmer l'achat de ce lot (\(String(selectedLot.cout)) points) ?", message: selectedLot.descriptionlot, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: "Default action"), style: .default, handler: { (action) in
            self.buyLot(lot: selectedLot)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Annuler", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"Cancel\" alert occured.")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func buyLot(lot: Lot) {
        if currentUser.nbpoints >= lot.cout {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            request.returnsObjectsAsFaults = false
            
            // Filtrer les données du CoreData User selon le userid, l'email utilisé dans firebase
            request.predicate = NSPredicate(format: "userid == %@", currentUser.userid!)
            
            do {
                if let results = try context.fetch(request) as? [User] {
                    let managedObject = results[0]
                    
                    managedObject.setValue(managedObject.nbpoints - lot.cout, forKey: "nbpoints")
                    try context.save()
                    
                    displayAlertController(alertTitle: "Succès", alertMessage: "Le lot a bien été obtenu, votre solde de point est actuellement de \(String(currentUser.nbpoints))", actionTitle: "OK")
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (LotsTableView)")
                
            }
        } else {
            displayAlertController(alertTitle: "Requête impossible", alertMessage: "Vous ne disposez pas de suffisamment de point pour obtenir ce lot", actionTitle: "OK")
        }
    }
    
    fileprivate func displayAlertController(alertTitle:String, alertMessage:String, actionTitle:String) {
        
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
