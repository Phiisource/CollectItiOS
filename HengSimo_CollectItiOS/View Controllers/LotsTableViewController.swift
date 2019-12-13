//
//  LotsTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class LotsTableViewController: UITableViewController {
    
    @IBOutlet var lots_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LotTableViewCell.reuseIdentifier, for: indexPath) as? LotTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Configure Cell
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Lot")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            let oneLot = results[indexPath.row] as! Lot
            
            cell.descriptionlot_label.text = oneLot.descriptionlot
            cell.coutlot_label.text = String(oneLot.cout)
            //IL RESTE ENCORE LA DATE DE VALIDITÉ À RÉCUPÉRER
            //cell.datevalidite_label.text =
        } catch {
            print(error)
        }

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
