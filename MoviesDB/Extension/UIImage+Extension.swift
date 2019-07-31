//
//  UIImage+Extension.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(url: String) {
        if (url.isEmpty) {
            self.image = UIImage(named: "MovieDB")!
            return
        }
        
        let remoteImageUrl = URL(string: "\(Constants.IMAGE_BASE_URL)/\(url)")!
        
        Alamofire.request(remoteImageUrl).responseData { [weak self] (response) in
            guard let strongSelf = self else { return }
            if response.error == nil {
                if let data = response.data {
                    strongSelf.image = UIImage(data: data)
                    strongSelf.layoutSubviews()
                }
            }
        }
    }
}
