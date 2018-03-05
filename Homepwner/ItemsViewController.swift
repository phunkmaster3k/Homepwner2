//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Nathan on 2/5/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    @IBAction func sortByName(_ sender: UIButton) {
        itemStore.sortby(type: "name")
        tableView.reloadData();
    }
    
    @IBAction func sortBySerial(_ sender: UIButton) {
        itemStore.sortby(type: "serial")
        tableView.reloadData();
        
    }
    @IBAction func sortByCost(_ sender: UIButton) {
        itemStore.sortby(type: "cost")
        tableView.reloadData();
    }
    
    //add button
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        //create new item
        let newItem = itemStore.createItem()
        
        //add new item to array
        if let idx = itemStore.allItems.index(of: newItem) {
            let idxPath = IndexPath(row: idx, section: 0)
            tableView.insertRows(at: [idxPath], with: .automatic)
        }
        
    }
    
    //edit button, save for referance
    /*@IBAction func toggleEditMode(_ sender: UIButton) {
        //switch text of button, toggle mode
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }*/
    
    //set table rows based on data array size
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    //populate cells with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.lblName.text = item.name
        cell.lblSerialNumber.text = item.serialNumber
        cell.lblValue.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    //on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "itemHeader")
        return header
    }
    
    //delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            //are you sure popup
            let title = "Delete \(item.name)?"
            let msg = "Are you really sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) -> Void in
                self.itemStore.removeItem(item)
                self.imageStore.deleteImage(forKey: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    //for moving list items
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //see itemStore class
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //sends data to next view via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        // showItem is the segue identifier
        case "showItem"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let dvc = segue.destination as! DetailViewController
                dvc.item = item
                dvc.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    //refresh data on return to view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
}
