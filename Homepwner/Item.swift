//
//  Item.swift
//  Homepwner
//
//  Created by Nathan on 2/5/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    //base constructor
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    //constructor with random or blank data
    convenience init(random: Bool = false) {
        
        if random {
            let adj = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
        
            var idx = arc4random_uniform(UInt32(adj.count))
            let randAdj = adj[Int(idx)]
        
            idx = arc4random_uniform(UInt32(nouns.count))
            let randNoun = nouns[Int(idx)]
        
            let randName = "\(randAdj) \(randNoun)"
            let randVal = Int(arc4random_uniform(100))
            let randSerial = UUID().uuidString.components(separatedBy: "-").first!
        
            self.init(name: randName, serialNumber: randSerial, valueInDollars: randVal)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeObject(forKey: "valueInDollars") as! Int
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
    }
}
