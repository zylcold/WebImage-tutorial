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
        
        guard let imageUrl = url else {
            self.image = placeholderImage
            return
        }
        //判断缓存
        if let image_cache = YLImageCache.default.imageFromMemoryCache(key: imageUrl.absoluteString) {
            self.image = image_cache
        }else {
            self.image = placeholderImage
            let dispatch = DispatchQueue.global()
            //下载
            dispatch.async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        YLImageCache.default.store(image: image, key: imageUrl.absoluteString)
                        self.image = image
                    }
                }
            }
        }
        
    }
}
