//
//  ViewExtension.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import UIKit
extension UIImageView {
    func yl_setImage(url: URL?, placeholderImage: UIImage?) -> Void  {
        self.image = placeholderImage
        guard let imageUrl = url else {
            return
        }
        let dispatch = DispatchQueue.global()
        dispatch.async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
