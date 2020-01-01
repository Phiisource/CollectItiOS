//
//  HistoriqueTableViewCell.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit

class HistoriqueTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "historiqueCell"
    
    var achat: Achat? {
        didSet {
            guard let achat = achat else { return }
            let depense = Int(achat.depense)
            
            if depense < 0 {
                nbpointshistorique_label.text = "\(String(depense)) pt"
            } else {
                nbpointshistorique_label.text = "+\(String(depense)) pt"
            }
            
            if achat.dateachat != nil {
                
                // Formater la date pour l'utiliser en string
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let dateString = formatter.string(from: achat.dateachat!)
                let dateachat = formatter.date(from: dateString)
                formatter.dateFormat = "dd/MM/yyyy"
                let dateStringFormat = formatter.string(from: dateachat!)

                datehistorique_label.text = dateStringFormat
                
            } else {
                datehistorique_label.text = "no data"
            }
            
            intitulehistorique_label.text = achat.descriptionachat
        }
    }

    @IBOutlet weak var datehistorique_label: UILabel!
    @IBOutlet weak var nbpointshistorique_label: UILabel!
    @IBOutlet weak var intitulehistorique_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
