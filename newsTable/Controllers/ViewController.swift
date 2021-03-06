//
//  ViewController.swift
//  newsTable
//
//  Created by 이철구 on 2020/11/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    var newsData : Array<Dictionary<String, Any>>?
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=Your Key")!) { (data, response, error) in
            if let dataJson = data {
                //print(newsData)
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    print(json)
                    let articles = json["articles"] as! Array<Dictionary<String,Any>>
                    self.newsData = articles
                    DispatchQueue.main.async {
                        self.tableViewMain.reloadData()
                    }
                } catch {
                    print("Error!! \(error)")
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //몇개?
        if let news = newsData {
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //무엇?
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        let idx = indexPath.row
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        if let news = newsData {
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"] as? String {
                    cell.labelText?.text = title
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        if let news = newsData {
            let row = news[indexPath.row]
            if let r = row as? Dictionary<String, Any> {
                if let imageUrl = r["urlToImage"] as? String {
                    controller.imageURL = imageUrl
                }
                if let desc = r["description"] as? String {
                    controller.descipt = desc
                }
            }
        }
        //showDetailViewController(controller, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "NewsDetail" == id {
            if let controller = segue.destination as? NewsDetailController {
                if let news = newsData {
                    if let indexPath = tableViewMain.indexPathForSelectedRow {
                        let row = news[indexPath.row]
                        if let r = row as? Dictionary<String, Any> {
                            if let imageUrl = r["urlToImage"] as? String {
                                controller.imageURL = imageUrl
                            }
                            if let desc = r["description"] as? String {
                                controller.descipt = desc
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        navigationItem.title = "나만의 뉴스"
        getNews()
    }
 
    //1. 데이터 무엇?
    //2. 데이터 몇개?
    //3.(옵션) 데이터 행 클릭
}

