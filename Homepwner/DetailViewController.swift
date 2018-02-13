//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Nathan on 2/13/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtSerial: UITextField!
    @IBOutlet var txtValue: UITextField!
    @IBOutlet var lblDate: UILabel!
    
    var item: Item!
    
    let numFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtName.text = item.name
        txtSerial.text = item.serialNumber
        txtValue.text = numFormatter.string(from: NSNumber(value: item.valueInDollars))
        lblDate.text = dateFormatter.string(from: item.dateCreated)
    }
    
}
