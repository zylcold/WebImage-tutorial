//
//  TableViewController.swift
//  WebImageView
//
//  Created by Jack-Wang on 2018/12/25.
//  Copyright © 2018 YLZ. All rights reserved.
//

import UIKit

class ImageTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageUrlDatas.urls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImageTableViewCell
        cell.imageView_p.yl_setImage(url: ImageUrlDatas.urls[indexPath.row], placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
}


class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageView_p: UIImageView!
}
