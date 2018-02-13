//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Nathan on 2/13/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtSerial: UITextField!
    @IBOutlet var txtValue: UITextField!
    @IBOutlet var lblDate: UILabel!
    
    //background tapped
    @IBAction func bgTapped(_ sender: UITapGestureRecognizer) {
        
        //hide keyboard
        view.endEditing(true)
    }
    
    
    var item: Item! {
        //set nav title
        didSet {
            navigationItem.title = item.name
        }
    }
    
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
    
    //fill text fields with data from item
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtName.text = item.name
        txtSerial.text = item.serialNumber
        txtValue.text = numFormatter.string(from: NSNumber(value: item.valueInDollars))
        lblDate.text = dateFormatter.string(from: item.dateCreated)
    }
    
    //when we leave view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //hide keyboard
        view.endEditing(true)
        
        //save data from text fields to item
        item.name = txtName.text ?? ""
        item.serialNumber = txtSerial.text ?? ""
        
        if let txtVal = txtValue.text, let val = numFormatter.number(from: txtVal) {
            item.valueInDollars = val.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    //hit enter on text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
