//
//  Extensions.swift
//  YouTube
//
//  Created by MAC on 2/8/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageUsingURLString(urlString: String) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }).resume()
    }
}
