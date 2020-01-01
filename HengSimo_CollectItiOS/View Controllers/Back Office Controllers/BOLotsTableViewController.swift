//
//  BOLotsTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class BOLotsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var lots = [Lot]()
    var filteredLots = [Lot]()
    var resultSearchController = UISearchController()
    
    @IBOutlet var lots_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLots()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.placeholder = "Rechercher un lot"
            controller.obscuresBackgroundDuringPresentation = false
            definesPresentationContext = true
            tableView.tableHeaderView?.addSubview(controller.searchBar)

            return controller
        })()
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
            handleReloadTableView()
            
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (resultSearchController.isActive) {
            return filteredLots.count
        } else {
            return lots.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BOLotTableViewCell.reuseIdentifier, for: indexPath) as? BOLotTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        

        // Attribuer un lot à la cellule et gestion de la recherche et des résultats affichés
        if (resultSearchController.isActive) {
            cell.lot = filteredLots[indexPath.row]
            return cell
        } else {
            cell.lot = lots[indexPath.row]
            return cell
        }
    }
    
    // Rafraîchir les données de la liste des lots à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchLots()
        handleReloadTableView()
    }

    @IBAction func switchBackToApp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredLots.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "descriptionlot CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (lots as NSArray).filtered(using: searchPredicate)
        filteredLots = array as! [Lot]

        handleReloadTableView()
    }
    
    fileprivate func handleReloadTableView() {
        self.tableView.reloadData()
        if lots.count == 0 {
            tableView.setEmptyView(title: "", message: "Aucun lot n'est disponible pour le moment")
        }
    }
}
