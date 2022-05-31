//
//  CategoryCollectionCellAndCollectionViewCell.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//


import UIKit //la 1 module chua class, struct, enum dung de tao UI

class CategoryCollectionCellAndCollectionViewCell: UICollectionViewCell {
    
    //khoi tao mot gia tri chua class, struct,enum de tao UI
    @IBOutlet weak var categorytitleimg: UIImageView!
    //
    
    @IBOutlet weak var backgroundimg: UIImageView!
    func updateCell(imagename: String,categorytitleimage: String)
    {
        //khoi tao tennoi dung chinh va img background cua categỏy
        self.backgroundimg.image = UIImage(named: imagename)
        self.categorytitleimg.image = UIImage(named: categorytitleimage)
    }
}


