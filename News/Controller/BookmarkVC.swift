//
//  BookmarkVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import UIKit
import CoreData

class BookmarkVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //Properties
    @IBOutlet weak var downloadsTableView: UITableView!
    var savedArticles = [DArticle]()
    var url: String!
    var titleArt: String!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set data cho tableview
        downloadsTableView.delegate = self
        downloadsTableView.dataSource = self
    }
    //
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    //Set tieu de cho UItableview
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bookmarks"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedArticles.count
    }
    //Do du lieu ra tableviewcell khi nguoi dung chon save va hien thi lại trên trang bookmark
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkcell")
        {
            cell.textLabel?.text = savedArticles[indexPath.row].title!
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        url = savedArticles[indexPath.row].articleurl!
        titleArt = savedArticles[indexPath.row].title!
        performSegue(withIdentifier: "ss", sender: self)
    }
    //Truyen du lieu sang cho BrowserDVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? BrowserBookmarkVC
        {
            des.url = url!
            des.titleArticle = titleArt!
        }
    }
    //Swipe action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (UITableViewRowAction, IndexPath) in
            self.deleteData(i: indexPath.row)
            self.getData()
            self.downloadsTableView.reloadData()
        }
        
        //Share action
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            self.sociaMediaShare(url: self.savedArticles[IndexPath.row].articleurl ?? "No url found")
            
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return [deleteAction,shareAction]
    }
    
    //MARK: function delete bookmarked articles
    func deleteData(i: Int)
    {
    guard let mc = AppDel?.persistentContainer.viewContext else {return }
        
        mc.delete(savedArticles[i])
        do
        {
            try mc.save()
        }
        
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    
    //chuc nang lay du lieu luu tru tai vi tri tren giao dien app cua fields ap dung coredata
    //MARK: Function get data (bookmarked articles) from local file using coredata
    func getData()
    {
        let fetchrequest = NSFetchRequest<DArticle>(entityName: "DArticle")
        do
        {
        guard  let mc = AppDel?.persistentContainer.viewContext else {return }
            savedArticles = try mc.fetch(fetchrequest)
            self.downloadsTableView.reloadData()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    //Chuc nang chia se bai viet
    func sociaMediaShare(url: String)
    {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
}
