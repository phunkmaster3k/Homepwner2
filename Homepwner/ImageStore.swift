//
//  ImageStore.swift
//  Homepwner
//
//  Created by Nathan on 2/15/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString,UIImage>()
    
    func imageURL(forKey key: String) -> URL {
        let docDirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = docDirs.first!
        return docDir.appendingPathComponent(key)
    }
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let e {
            print("Error removing image from disk: \(e)")
        }
        
    }
}
