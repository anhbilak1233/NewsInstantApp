//
//  HeadLinesCellTableViewCell.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

//Custom table view cell
import Foundation

import SDWebImage //tai hinh anh bat dong bo khong lam anh huong den UI Thread

class HeadLinesCellTableViewCell: UITableViewCell {
    @IBOutlet weak var headlinesimageview: UIImageView!
    @IBOutlet weak var headlinestitlelbl: UILabel!
    @IBOutlet weak var headlinesbodylbl: UILabel!
    //Tao trang thai neu hinh anh cua bai viet khong ton tai 
    func updateCell(title: String,body: String,imgurl: String)
    {
        headlinestitlelbl.text = title //
        headlinesbodylbl.text = body
        headlinesimageview.sd_setImage(with: URL(string: imgurl), completed: nil)
        if headlinesimageview.image == nil
        {
            headlinesimageview.image = UIImage(named: "no-image-2.png")
        }
    }
}
