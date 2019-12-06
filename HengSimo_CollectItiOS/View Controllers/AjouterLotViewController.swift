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
        // Do any additional setup after loading the view.
    }

    @IBAction func sendAjouterLotButton(_ sender: RoundButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newModule = NSEntityDescription.insertNewObject(forEntityName: "Lot", into: context)
        newModule.setValue(intitulelot_label.text, forKey: "descriptionlot")
        newModule.setValue(Int(coutlot_label.text!), forKey: "cout")
        //newModule.setValue(credits_textfield.text, forKey: "credits")
        
        do {
            try context.save()
            print("***************** AJOUT LOT FAIT *****************")
        } catch {
            print("ERREUR : impossible de sauvegarder mon context")
        }
    }
    
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
            print("***************** TOUS LES LOTS ONT ETE SUPPRIMES *****************")
        } catch let error {
            print("Detele all data in Modules error :", error)
        }
    }
    
    //Pour autoriser seulement les entiers dans le champs pour le coût
    //Il faudrait afficher uniquement le clavier avec des nombres
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        //textField.keyboardType = UIKeyboardType.decimalPad
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
