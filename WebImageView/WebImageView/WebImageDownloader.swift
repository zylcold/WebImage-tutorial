//
//  WebImageDownloader.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import Foundation
import UIKit
//WebImageDownloader 网络下载，并返回执行操作
class YLWebImageDownloader {
    let queue: OperationQueue
    static let `default` = YLWebImageDownloader()
    
    init() {
        queue = OperationQueue()
    }
    
    func loadImage(url: URL?, completed: @escaping (UIImage?, NSError?, URL?) -> Void) -> BlockOperation? {
        guard let imageUrl = url else {
            return nil
        }
        let opreation = BlockOperation {
            let data = try? Data(contentsOf: imageUrl)
            if let imageData = data, let image = UIImage(data: imageData) {
                completed(image, nil, imageUrl)
            }else {
                completed(nil, NSError(domain: "com.yunlongz.webimage", code: 10010, userInfo: [NSDebugDescriptionErrorKey: "network error"]), imageUrl)
            }
        }
        
        queue.addOperation(opreation)
        return opreation
    }
}
