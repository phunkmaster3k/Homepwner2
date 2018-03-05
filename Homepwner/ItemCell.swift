//
//  ItemCell.swift
//  Homepwner
//
//  Created by Nathan on 2/13/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    //labels for data in cell
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSerialNumber: UILabel!
    @IBOutlet var lblValue: UILabel!
    
    //adjust size based on data if needed
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //lblName.adjustsFontForContentSizeCategory = true
        //lblSerialNumber.adjustsFontForContentSizeCategory = true
        //lblValue.adjustsFontForContentSizeCategory = true
    }
    
}
