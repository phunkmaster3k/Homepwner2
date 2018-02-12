//
//  ItemStore.swift
//  Homepwner
//
//  Created by Nathan on 2/5/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    /* init() {
        for _ in 0..<5 {
            createItem()
        }
    } */
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let idx = allItems.index(of: item) {
            allItems.remove(at: idx)
        }
    }
    
    func moveItem(from fromIdx: Int, to toIdx: Int) {
        if fromIdx == toIdx {
            return
        }
        
        let movedItem = allItems[fromIdx]
        allItems.remove(at: fromIdx)
        allItems.insert(movedItem, at: toIdx)
        
    }
    
}
