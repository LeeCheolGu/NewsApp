//
//  ViewController.swift
//  newsTable
//
//  Created by 이철구 on 2020/11/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //몇개?
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //무엇?
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        cell.labelText?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
    }
 
    //1. 데이터 무엇?
    //2. 데이터 몇개?
    //3.(옵션) 데이터 행 클릭
}

