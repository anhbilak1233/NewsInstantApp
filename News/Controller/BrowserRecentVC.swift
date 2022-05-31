//
//  BrowserRecentVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import KSBGradientView // Hien thi thanh tren cua chi tiet voi mau sac duocj gan tu tim den nhat dan
//
import WebKit //framework co san dung de hien thi doc chi tiet bai viet

class BrowserRecentVC: UIViewController{
    @IBOutlet weak var titlenewslbl: UILabel!
     
    //truyen và lấy dữ liệu từ ViewController
    
    var url: String?
    var newstitle: String?
    
    //doc chi tiet tin tuc
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var closebtn: UIButton!
    
    
    //hien thị noi dung thanh navbar
    @IBOutlet weak var titlebarview: UIView!
    
    //hien thi dg dan loa noi dung news
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // hien thi mau co san tren thanh tieu de chi tiet
        titlebarview.applyVerticalGradient(startcolor: UIColor.purple, endcolor: UIColor.systemPink)
        
        if let titles = newstitle{
            titlenewslbl.text = titles
        }
        
        if let newsurl = url{
            webView.load(URLRequest(url: URL(string: newsurl)!))
        }
    }
    //nut thoat bai viet
    @IBAction func closebtn(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
