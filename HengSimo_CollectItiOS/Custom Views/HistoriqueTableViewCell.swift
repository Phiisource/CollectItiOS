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

    @IBOutlet weak var datehistorique_label: UILabel!
    @IBOutlet weak var nbpointshistorique_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
