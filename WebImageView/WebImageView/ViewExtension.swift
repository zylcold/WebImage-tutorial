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
        
        let validOperationKey = NSStringFromClass(type(of: self))
        self.image = placeholderImage
        guard let imageUrl = url else {
            return
        }
        self.yl_cancelImageLoadOperation(key: validOperationKey)
        let operation = YLWebImageManager.default.loadImage(url: imageUrl) { [unowned self](image, error, url) in
            if let iimage = image {
                self.image = iimage
            }
        }
        self.yl_setImageLoad(operation: operation, key: validOperationKey)
        
    }
}


extension UIView {
    typealias YLOperationsDictionary = NSMapTable<NSString, YLWebImageCombinedOperation>
    private func yl_operationDictionary() -> YLOperationsDictionary {
        objc_sync_enter(self)
        let operations = objc_getAssociatedObject(self, UnsafePointer(bitPattern: "sd_operationDictionary".hashValue)!)
        if let operations_p = operations as? YLOperationsDictionary {
            return operations_p
        }
        let operations_new = YLOperationsDictionary(keyOptions: .copyIn, valueOptions: .strongMemory)
        objc_setAssociatedObject(self,  UnsafePointer(bitPattern: "sd_operationDictionary".hashValue)!, operations_new, .OBJC_ASSOCIATION_RETAIN)
        objc_sync_exit(self)
        return operations_new
        
    }
    func yl_setImageLoad(operation: YLWebImageCombinedOperation?, key: String?) {
        guard let key_p = key else {
            return
        }
        if let operations = self.yl_operationDictionary().object(forKey: key_p as NSString) {
            operations.cancel()
        }
        if let operation_p = operation {
            objc_sync_enter(self)
            self.yl_operationDictionary().setObject(operation_p, forKey: key_p as NSString)
            objc_sync_exit(self)
        }
    }
    
    func yl_cancelImageLoadOperation(key: String?) {
        guard let key_p = key else {
            return
        }
        objc_sync_enter(self)
        if let operations =  self.yl_operationDictionary().object(forKey: key_p as NSString) {
            operations.cancel()
        }
        objc_sync_exit(self)
    }
    func yl_removeImageLoadOperation(key: String?) {
        guard let key_p = key else {
            return
        }
        objc_sync_enter(self)
        self.yl_operationDictionary().removeObject(forKey: key_p as NSString)
        objc_sync_exit(self)
    }
}
