//
//  SingleLotTableViewCell.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 05/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit

class LotTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "lotCell"
    
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
