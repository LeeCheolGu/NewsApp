//
//  NewsDetailController.swift
//  newsTable
//
//  Created by 이철구 on 2020/11/16.
//

import UIKit

class NewsDetailController: UIViewController {
    
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var labelMain: UILabel!
    
    var imageURL: String?
    var descipt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = imageURL {
            if let data = try? Data(contentsOf: URL(string: img)!) {
                DispatchQueue.main.async {
                    self.imageMain.image = UIImage(data: data)
                }
            }
        }
        if let desc = descipt {
            self.labelMain.text = desc
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.navigationItem.title = "Back"
        }
    }
}
