//
//  BrowserBookmarkVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import KSBGradientView //tao hieu ung mau nen cho UIView
import WebKit //hien thi trang web dua vao du lieu dc truyen vao (chuoi html, url)

class BrowserBookmarkVC: UIViewController {
    //Properties
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    //url, titleArticle duoc truyen tu DownloadsVC
    var url: String!
    var titleArticle: String!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hien thi chi tiet trang web bang wkwebview
        webView.load(URLRequest(url: URL(string:url!)!))
        lbTitle.text = titleArticle!
    }
   //Nut exit
    @IBAction func closebtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

