//
//  ItemCell.swift
//  Homepwner
//
//  Created by Nathan on 2/13/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSerialNumber: UILabel!
    @IBOutlet var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblName.adjustsFontForContentSizeCategory = true
        lblSerialNumber.adjustsFontForContentSizeCategory = true
        lblValue.adjustsFontForContentSizeCategory = true
    }
    
}
