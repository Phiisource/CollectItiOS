//
//  BOLotsTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class BOLotsTableViewController: UITableViewController {
    
    var lots = [Lot]()
    
    @IBOutlet var lots_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLots()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BOLotTableViewCell.reuseIdentifier, for: indexPath) as? BOLotTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        let lot = lots[indexPath.row]

        // Attribuer un lot à la cellule
        cell.lot = lot
        return cell
    }
    
    // Rafraîchir les données de la liste des lots à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchLots()
        tableView.reloadData()
    }

    @IBAction func switchBackToApp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
