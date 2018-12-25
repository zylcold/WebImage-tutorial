//
//  WebImageManager.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import Foundation
import UIKit

class YLWebImageCombinedOperation {
    var downloaderOperation: Operation?
    var isCancel = false
    func cancel() {
        downloaderOperation?.cancel()
        isCancel = true
    }
}

class YLWebImageManager {
    static let `default` = YLWebImageManager()
    private let imageCache = YLImageCache.default
    func loadImage(url: URL?, completed: @escaping (UIImage?, NSError?, URL?) -> Void) -> YLWebImageCombinedOperation {
        let operation = YLWebImageCombinedOperation()
        guard let imageUrl = url else {
            return operation
        }
        if let image = YLImageCache.default.imageFromMemoryCache(key: imageUrl.absoluteString) {
            completed(image, nil, imageUrl)
            return operation
        }
        
        operation.downloaderOperation = YLWebImageDownloader.default.loadImage(url: imageUrl) { (image, error, url) in
            if let image_p = image, let url_p = url {
                YLImageCache.default.store(image: image_p, key: url_p.absoluteString)
            }
            DispatchQueue.main.async {
                if(!operation.isCancel) {
                    completed(image, error, url)
                }
            }
        }
        return operation
    }
}
