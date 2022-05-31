//
//  RecentVC.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

// core data: //luu tru du lieu tren dien thoai(khong cap ap dung call API)
// SVPproressHUD hien thi deads up dislay(load du lieu len man hinh doi)
// Network ket noi mang de send va take data
//su dung firebase de tao du kien de load API News
import CoreData
import SVProgressHUD
import Network
import Firebase


//tham chieu den noi dung ung dung
let AppDel = UIApplication.shared.delegate as? AppDelegate

class RecentVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
   //Properties
    var monitor = NWPathMonitor()
    var articles = [Articles]()
    var newsurl: String!
    var newstitle: String!
    let d = DArticle()
    let database=Database.database().reference()
    //khoi tao gia tri so luong truy cap vao ung dung
    let defaultValues:[String:Int]=[
        "heathViews":0,
        "scienceViews":0,
        "entertainmentViews":0,
        "technologyViews":0,
    ]
    //get id iphone
    let idIphone = UIDevice.current.identifierForVendor?.uuidString
    //
    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var headlinestableview: UITableView!
    
    
    //Gia tri khi view controller  duoc luu tru vao bo nho data -> func viewDidLoad chi duoc load du lieu vao man hinh chi 1 lan duy nhat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set dafault value if id iphone is not exists(Gia tri ko khac khi dien thoai khong ton tai)
        database.child("views/\(idIphone!)").getData{ [self]  (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
                //dem du lieu va se tu thoat neu ko ton tai
            else if snapshot!.exists() {
                print("No data available")
                //set default value by id phone
                self.database.child("views/\(self.idIphone!)").setValue(self.defaultValues)
            }
        }
        //Show error mess khi khong co internet(not connection)
        monitor.pathUpdateHandler = { path in
            
            if path.status == .unsatisfied
            {
                SVProgressHUD.showError(withStatus: "No internet connection")
                return
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        //Lay tin tuc
        //
        if headlinestableview.visibleCells.isEmpty
        {
            //show HUD --
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            SVProgressHUD.setBorderWidth(2)
            SVProgressHUD.setHapticsEnabled(true)
            SVProgressHUD.setRingThickness(4)
            
        }
        title = "Headlines"
        self.headlinestableview.delegate = self
        self.headlinestableview.dataSource = self
        NetworkService.sharedobj.getHeadLines { (a) in
            self.articles = a
            self.headlinestableview.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    //tra ve so news
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeadLinesCellTableViewCell
        {
            
            let data = articles[indexPath.row]
            //Set default content khi khong lay duoc tu api
            //noi dung se hiej thi khong co gia tri hoacj gui gia trij den trang dinh san
            cell.updateCell(title:data.title ?? "Not Found", body: data.content ?? "No Body", imgurl: data.urlToImage ?? "https://en.wikipedia.org/wiki/Pages_(word_processor)#/media/File:Pages_Icon.png")
            return cell
        }
        return UITableViewCell()
    }
    //gia tri se bao
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsurl = articles[indexPath.row].url!
        newstitle = articles[indexPath.row].title!
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    //chuyen du lieu sang BrowserVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? BrowserRecentVC
        {
            destinationVC.url = newsurl
            destinationVC.newstitle = newstitle
        }
        
    }
    //Swipe action
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            
           
            self.socialMediaShare(index: indexPath.row)
            
            
        }
        
        action.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
        let save = UITableViewRowAction(style: .normal, title: "Save") { (UITableViewRowAction, IndexPath) in
            self.saveData(i: IndexPath.row)
        }
        
        save.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        return [action, save]
    }
    
    
    //Lay noi dung html cua duong dan
    func getContentFromURL(){
        if let urlDL = URL(string: newsurl!){
            do {
                let contents = try String(contentsOf: urlDL)
            } catch {
                // contents could not be loaded
                SVProgressHUD.showError(withStatus: "URL could not be loaded")
            }
        }
    }
    //xu ly luu tru data vao bookmart
    func saveData(i: Int)
    {
        //Lay gai tri content
        guard let managedContext = AppDel?.persistentContainer.viewContext else {return }
        //Lay coredate
        let articetobesave = DArticle(context: managedContext)
        //Gan du lieu cho coredate
        articetobesave.title = articles[i].title!
        articetobesave.articleurl = articles[i].url!
        
        do{
            //Xu ly luu data
          try  managedContext.save()
            
            
            //Thong bao khi luu thanh cong
            let ac = UIAlertController(title: "Info", message: "Article has been actived successful", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
            
            
        }
        
        catch{
            print(error.localizedDescription)
        }
        print("Added to bookmark")
        
        
    }
    
    //Chuc nang chia se News (baif viet tin tuc)
    func socialMediaShare(index: Int)
    {
        let vc = UIActivityViewController(activityItems: [articles[index].url ?? "Not found"], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    //Nut refresh
    @IBAction func refreshbtn(_ sender: Any) {
        
        
        NetworkService.sharedobj.getHeadLines { (a) in
            
            //HUD
            SVProgressHUD.show(withStatus: "Loading...")
            self.articles = a
            self.headlinestableview.reloadData()
            SVProgressHUD.dismiss(withDelay: 2)
        }
        
    }
}


