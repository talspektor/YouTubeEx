//
//  Extentions.swift
//  YouTubeEx
//
//  Created by user140592 on 1/6/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb (red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        // Load image from cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                
                guard let imageTocache = UIImage(data: data) else { return }
                
                if self.imageUrlString == urlString {
                     self.image = imageTocache
                }
                
                imageCache.setObject(imageTocache , forKey: urlString as AnyObject)
            }
            }.resume()
        

    }
}
