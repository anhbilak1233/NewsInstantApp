//
//  BrowserCategoryNewsVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import SVProgressHUD
import KSBGradientView
import WebKit //hien thi trang web dua vao du lieu dc truyen vao theo chuoi HTML, url
class BrowserCategoryNewsVC: UIViewController, WKNavigationDelegate {
    //Properties
    //url, ntitle duoc truyen tu CategoryNewsVC
    var url: String?
    var ntitle: String!
    @IBOutlet weak var webviewnews: WKWebView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var titleview: UIView!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //mau cho tieu de dung KSBGradientView
        titleview.applyHorizontalGradient(startcolor: UIColor.purple, endcolor: UIColor.blue)
       if let u = url
       {
        //load du lieu khi ngdung click vào bài viết bát kì trên list
        //ap dung webview
        //duong dan tu API
        webviewnews.load(URLRequest(url: URL(string:u)!))
       }
       else
       {
        //Thong bao bai viet khong tôn tai
        let ac = UIAlertController(title: "Error", message: "URL Not found", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //hiẹn thi thong bao
        present(ac, animated: true, completion: nil)
       }
       if let titlenews = ntitle
       {
        titlelbl.text = titlenews
       }
       else
       {
        titlelbl.text = ""
       }
    }
   //Nut thoat
    @IBAction func closebtnclicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
