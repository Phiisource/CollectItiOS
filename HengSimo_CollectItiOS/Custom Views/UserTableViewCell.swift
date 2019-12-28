//
//  UserTableViewCell.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "userCell"
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            emailuser_textfield.text = user.userid
            nomuser_textfield.text = user.nom
            prenomuser_textfield.text = user.prenom
            
            if user.dateinscription != nil {
                
                // Formater la date pour l'utiliser en string
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let dateString = formatter.string(from: user.dateinscription!)
                let dateinscription = formatter.date(from: dateString)
                formatter.dateFormat = "dd/MM/yyyy"
                let dateStringFormat = formatter.string(from: dateinscription!)

                dateinscriptionuser_textfield.text = dateStringFormat
                
            } else {
                dateinscriptionuser_textfield.text = "no data"
            }
        }
    }
    
    @IBOutlet weak var emailuser_textfield: UILabel!
    @IBOutlet weak var nomuser_textfield: UILabel!
    @IBOutlet weak var prenomuser_textfield: UILabel!
    @IBOutlet weak var dateinscriptionuser_textfield: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
