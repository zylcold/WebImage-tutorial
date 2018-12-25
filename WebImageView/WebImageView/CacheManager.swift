//
//  CacheManager.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import Foundation
import UIKit
class YLImageCache {
    //单例
    static let `default` = YLImageCache(namespace: "com.yunlongz.webimage")
    //键值缓存
    private lazy var memCache = [String: UIImage]()
    private var namespace: String
    
    init(namespace: String) {
        self.namespace = namespace
    }
    //存
    func store(image: UIImage, key: String) {
        self.memCache[key] = image
    }
    //查
    func imageFromMemoryCache(key: String) -> UIImage? {
        return self.memCache[key]
    }
    //删
    func removeImage(key: String) {
        self.memCache[key] = nil
    }
    //清
    func removeAllImage() {
        self.memCache.removeAll()
    }
}
