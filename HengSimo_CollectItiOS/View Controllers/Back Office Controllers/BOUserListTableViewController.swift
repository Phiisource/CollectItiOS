//
//  BOUserListTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class BOUserListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var searchUserBar: UISearchBar!
    
    var users = [User]()
    var selectedUser: User?
    var filteredUsers = [User]()
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUsers()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.placeholder = "Recherche par email"
            controller.obscuresBackgroundDuringPresentation = false
            definesPresentationContext = true
            tableView.tableHeaderView?.addSubview(controller.searchBar)

            return controller
        })()
    }

    
    fileprivate func fetchUsers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            // Récupérer les users du CoreData
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return }
            self.users = users
            self.tableView.reloadData()
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configurer la cellule
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        if (resultSearchController.isActive) {
            cell.user = filteredUsers[indexPath.row]

            return cell
        }
        else {
            cell.user = users[indexPath.row]
            return cell
        }
        
        //let user = users[indexPath.row]
        
        // Attribuer à la cellule un utilisateur
        //cell.user = user
        //return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Garder en cache l'utilisateur sélectionné
        selectedUser = users[indexPath.row]
        
        // Afficher la vue profil utilisateur
        performSegue(withIdentifier: "showUserProfileBO", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Transférer l'utilisateur sélectionné dans la tableview au view controller du profil utilisateur
        if segue.identifier == "showUserProfileBO" {
            let vc = segue.destination as? UserProfileViewController
            
            // Initialiser l'utilisateur à afficher dans la vue profil à l'utilisateur sélectionné dans la table view
            vc?.user = selectedUser
        }
    }
    
    
    // Rafraîchir les données de la liste des users à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUsers()
        tableView.reloadData()
    }

    @IBAction func switchBackToApp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredUsers.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "userid CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (users as NSArray).filtered(using: searchPredicate)
        filteredUsers = array as! [User]

        self.tableView.reloadData()
    }
}
