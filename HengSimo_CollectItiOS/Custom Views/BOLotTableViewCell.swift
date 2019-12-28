//
//  BOLotTableViewCell.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 17/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit

class BOLotTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "lotCellBO"
    
    var lot: Lot? {
        didSet {
            guard let lot = lot else { return }
            descriptionlot_label.text = lot.descriptionlot
            coutlot_label.text = String(lot.cout)
                
            // Formater la date pour l'utiliser en string
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateString = formatter.string(from: lot.datevalidite!)
            let datevalidite = formatter.date(from: dateString)
            formatter.dateFormat = "dd/MM/yyyy"
            let dateStringFormat = formatter.string(from: datevalidite!)

            datevalidite_label.text = "Valable jusqu'au \(dateStringFormat)"
        }
    }
    
    @IBOutlet weak var descriptionlot_label: UILabel!
    @IBOutlet weak var coutlot_label: UILabel!
    @IBOutlet weak var datevalidite_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
