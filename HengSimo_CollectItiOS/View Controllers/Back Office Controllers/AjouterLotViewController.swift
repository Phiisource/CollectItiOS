//
//  AjouterLotViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import CoreData

class AjouterLotViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var intitulelot_label: UITextField!
    @IBOutlet weak var coutlot_label: UITextField!
    @IBOutlet weak var datelot_picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Fonction d'ajout d'un lot quand le bouton ajouter est cliqué
    @IBAction func sendAjouterLotButton(_ sender: RoundButton) {
        
        // Vérifier si les champs sont remplis
        if intitulelot_label.text != "" && coutlot_label.text != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newLot = NSEntityDescription.insertNewObject(forEntityName: "Lot", into: context)
            newLot.setValue(intitulelot_label.text, forKey: "descriptionlot")
            newLot.setValue(Int(coutlot_label.text!), forKey: "cout")
            newLot.setValue(datelot_picker.date, forKey: "datevalidite")
            
            do {
                
                try context.save()
                
                // Afficher un message de succès
                let alertController = UIAlertController(title: "Succès", message:
                    "Le lot a bien été ajouté", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
            } catch {
                
                // Afficher un message d'échec
                let alertController = UIAlertController(title: "Échec", message:
                    "Le lot n'a pas pu être ajouté", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        } else {
            
            // Sinon, si un des champs est vide, afficher un message de complétion des champs
            let alertController = UIAlertController(title: "Alerte", message:
                "Veuillez remplir tous les champs", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // Fonction de suppression des lots disponibles quand le bouton supprimer est cliqué
    @IBAction func sendSupprimerLotsButton(_ sender: RoundButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lot")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            
            // Afficher un message de succès de la suppression des lots
            let alertController = UIAlertController(title: "Suppression des lots", message:
                "Tous les lots ont bien été supprimés", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
        } catch {
            
            // Afficher un message d'erreur sur l'échec de la suppression des lots
            let alertController = UIAlertController(title: "Échec", message:
                "La suppression des lots n'a pas pu s'effectuer", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // Pour autoriser seulement les entiers dans le champs pour le coût
    // Il faudrait afficher uniquement le clavier avec des nombres
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}