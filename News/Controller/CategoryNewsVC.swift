//
//  CategoryNewsVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

// SVPproressHUD hien thi deads up dislay(load du lieu len man hinh doi)
// Network ket noi mang de send va take data
//su dung firebase de tao du kien de load API News
import Network
import SVProgressHUD
import Firebase

class CategoryNewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //Properties
    var articles = [Articles]()
    var newsurl: String?
    var ntitle: String?
    //Man hinh..
    let monitor = NWPathMonitor()
    var i:Int!
    @IBOutlet weak var tv: UITableView!
    //tao bien database
    let database=Database.database().reference()
    
    //get id iphone
    let idIphone=UIDevice.current.identifierForVendor?.uuidString
    //
    
    //Xu ly dem so lan truy cap category
    func getAndSetViews(category: String?){
        database.child("views/\(idIphone!)").getData{ [self] (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot!.exists() {
                let value = snapshot?.value as! [String: Int]
                var views=value[category!]!
                //increase views
                views+=1
                self.database.child("views/\(self.idIphone!)/\(category!)").setValue(views)
            }
        }
    }
    
    
    //Hien thi gia trị neu nguoi dung khong ket noi internet
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor.pathUpdateHandler = { path in
            
            if path.status == .unsatisfied
            {
                SVProgressHUD.showError(withStatus: "No internet connection")
                return
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        //Xu ly show du lieu tuong ung theo category
        if i == 0
        {
           //MARK:firebase Health
            //dem so lan truy cap vao category
            getAndSetViews(category: "heathViews")
            //
            title = "Health News"
            
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Loading news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            tv.delegate = self
                         tv.dataSource = self
            //hien thi list bai viet cua tung category
            NetworkService.sharedobj.getHealthNews { (articles) in
               
                self.articles = articles
                print(self.articles.count)
                self.tv.reloadData()
                
                SVProgressHUD.dismiss()
              
            }
        }
        
        else if i == 3
        {
            //MARK:firebase Technology
            //dem so lan truy cap vao category
             getAndSetViews(category: "technologyViews")
             //
           title = "Technology News"
            
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Loading news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            
            tv.delegate = self
            tv.dataSource = self
            //hien thi list bai viet cua tung category
            NetworkService.sharedobj.getTechNews { (a) in
                self.articles = a
                print(a.count)
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        }
        else if i == 2
        {
            //MARK:firebase entertainment
             getAndSetViews(category: "entertainmentViews")
             //
            title = "Entertaiment News"
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Loading news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            //hien thi list bai viet cua tung category
            NetworkService.sharedobj.getEntertainmentNews { (a) in
                self.articles = a
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        }
        else if i == 1
        {
            //MARK:firebase science
             getAndSetViews(category: "scienceViews")
             //
            title = "Science News"
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Loading news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            NetworkService.sharedobj.getScienceNews { (a) in
                self.articles = a
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                
                SVProgressHUD.dismiss()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    //Xu ly khi khong lay duoc du lieu
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellnews") as? HeadLinesCellTableViewCell
        {
            cell.updateCell(title: articles[indexPath.row].title ?? "No title", body: articles[indexPath.row].content ?? "No body", imgurl: articles[indexPath.row].urlToImage ?? "https://en.wikipedia.org/wiki/Pages_(word_processor)#/media/File:Pages_Icon.png")
            
            return cell
        }
        
        return UITableViewCell()
        
    }

    //bao loi neu ng dung hien th tren hang
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nurl = articles[indexPath.row].url
        {
            self.newsurl = nurl
        }
        
        if let ntit = articles[indexPath.row].title
        {
            self.ntitle = ntit
        }
        
        performSegue(withIdentifier: "bsegue", sender: self)
    }
    
    //Swipe action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Share
        let action = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            
           
            self.socialMediaShare(index: indexPath.row)
            
            
        }
        
        action.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        //save Bookmark
        let saveAction = UITableViewRowAction(style: .default, title: "Save") { (UITableViewRowAction, IndexPath) in
            self.saveData(i: indexPath.row)
        }
        
        saveAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return [action,saveAction]
    }
    //Chuc nang luu bai viet vao bookmark
    func saveData(i: Int)
    {
    guard let mc = AppDel?.persistentContainer.viewContext else {return}
        let a = DArticle(context: mc)
        a.title = articles[i].title!
        a.articleurl = articles[i].url!
        do
        {
            //thong bao da luu thanh cong bai viet
            try mc.save()
            let ac = UIAlertController(title: "Info", message: "Article has been actived successful!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
           
        }
        
        catch
        {
            print(error.localizedDescription)
        }
    }
    //Chuc nang chia se bai viet ShareNews cua category
    func socialMediaShare(index: Int)
    {
        let vc = UIActivityViewController(activityItems: [articles[index].url ?? "Not found"], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
 //Truyen tham so sang cho man hinh hien thi chi tiet
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BrowserCategoryNewsVC
        {
            destinationVC.url = self.newsurl
            destinationVC.ntitle = self.ntitle
        }
    }
}
