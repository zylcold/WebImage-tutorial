//
//  ViewController.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView(frame: CGRect(x: 40, y: 100, width: 100, height: 100))
    let url = ImageUrlDatas.randomUrl
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        if let imageData = try? Data(contentsOf: url)  {
            self.imageView.image = UIImage(data: imageData)
        }
    }


}

