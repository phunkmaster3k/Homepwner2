//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Nathan on 2/13/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDropInteractionDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtSerial: UITextField!
    @IBOutlet var txtValue: UITextField!
    @IBOutlet var lblDate: UILabel!
    
    @IBAction func takePic(_ sender: UIBarButtonItem) {
        let imgPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imgPicker.sourceType = .camera
        } else {
            imgPicker.sourceType = .photoLibrary
        }
        
        imgPicker.delegate = self
        present(imgPicker,animated: true, completion: nil)
        
    }
    
    //background tapped
    @IBAction func bgTapped(_ sender: UITapGestureRecognizer) {
        
        //hide keyboard
        view.endEditing(true)
    }
    
    
    var myItem: Item! {
        //set nav title
        didSet {
            navigationItem.title = myItem.name
        }
    }
    
    var imageStore: ImageStore!
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.addInteraction(UIDropInteraction(delegate: self))
    }
    
    //fill text fields with data from item
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtName.text = myItem.name
        txtSerial.text = myItem.serialNumber
        txtValue.text = numFormatter.string(from: NSNumber(value: myItem.valueInDollars))
        lblDate.text = dateFormatter.string(from: myItem.dateCreated)
        
        let imgDisplay = imageStore.image(forKey: myItem.itemKey)
        
        imageView.image = imgDisplay
    }
    
    //when we leave view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //hide keyboard
        view.endEditing(true)
        
        //save data from text fields to item
        myItem.name = txtName.text ?? ""
        myItem.serialNumber = txtSerial.text ?? ""
        
        if let txtVal = txtValue.text, let val = numFormatter.number(from: txtVal) {
            myItem.valueInDollars = val.intValue
        } else {
            myItem.valueInDollars = 0
        }
    }
    
    //hit enter on text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
    //returns the picked/taken image to the view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageStore.setImage(img, forKey: myItem.itemKey)
        imageView.image = img
        dismiss(animated: true, completion: nil)
        
    }
    
    //can the dragged item be used in the UIImage class
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    //what to do with the dragged item, in this case copy it
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            item.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, err) in
                
                let draggedImage = obj as? UIImage
                
                //these must be on main thread
                DispatchQueue.main.async {
                    self.imageStore.setImage(draggedImage!, forKey: self.myItem.itemKey)
                    self.imageView.image = draggedImage
                }
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
