//
//  HistoriqueTableViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class HistoriqueTableViewController: UITableViewController {
    
    var userHistorique = [Achat]()
    var currentUser = User()
    @IBOutlet var historiqueTV: UITableView!
    
    @IBOutlet weak var switchBO_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUser()
        fetchUserHistorique()
        
        handleReloadTableView()
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
                        
                    } else {
                        
                        switchBO_button.isHidden = true
                        
                    }
                }
            } catch {
                
                fatalError("Problème fetch user CoreData (HistoriqueVC)")
                
            }
            
        }
    }
    
    fileprivate func fetchUserHistorique() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Achat")
        
        request.returnsObjectsAsFaults = false
        
        // Filtrer les données du CoreData User selon le userid, l'email utilisé dans firebase
        request.predicate = NSPredicate(format: "userid == %@", currentUser.userid!)
        
        do {
            
            // Récupérer les lots du CoreData
            let results = try context.fetch(request)
            guard let historique = results as? [Achat] else { return }
            self.userHistorique = historique
            handleReloadTableView()
            
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userHistorique.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoriqueTableViewCell.reuseIdentifier, for: indexPath) as? HistoriqueTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        cell.achat = userHistorique[indexPath.row]
        
        return cell
    }

    // Rafraîchir les données de la liste des lots à chaque affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrentUser()
        fetchUserHistorique()
        handleReloadTableView()
    }
    
    fileprivate func handleReloadTableView() {
        self.tableView.reloadData()
        if userHistorique.count == 0 {
            tableView.setEmptyView(title: "", message: "Historique vide")
        }
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        //titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        //messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
