//
//  ViewController.swift
//  splittable
//
//  Created by Julia on 11/10/16.
//  Copyright © 2016 6eff. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var items = [UserObject]()
    var jsonObj: JSON!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestURL: NSURL = NSURL(string: "https://sheetsu.com/apis/v1.0/aaf79d4763af")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {dataFromNetwork, response, error -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                
                do{
                    
                    let json = JSON(data: dataFromNetwork!)
                    self.jsonObj = json
                    let arrayResults = json.arrayValue
                    let sortedResults = arrayResults.sorted { $0["sort_order"].doubleValue < $1["sort_order"].doubleValue }
                    if let results = sortedResults as Array! {
                        for entry in results {
                            self.items.append(UserObject(json: entry))
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                                           }
                    
                }
            }
    })
    
        task.resume()
}
    override func viewWillAppear(_ animated: Bool) {
        let frame:CGRect = CGRect(x: 100, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
        self.tableView = UITableView(frame: frame)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        let btn = UIButton(frame: CGRect(x: 25, y: 25, width: self.view.frame.width, height: 50))
        btn.backgroundColor = UIColor.green
        btn.setTitle("LIST", for: UIControlState.normal)
        self.view.addSubview(btn)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return self.items.count;
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt IndexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CELL")
        }
       
        let user = self.items[IndexPath.row]
        if let img_url = NSURL(string: user.imageUrl) {
            if let data = NSData(contentsOf: img_url as URL) {
                cell?.imageView?.image = UIImage(data: data as Data)
              
            }
            print(img_url)
        }
        
        if user.name != "Banner" {
            cell!.textLabel?.text = user.name
        }
        let url = user.url
        let tapGesture:UITapGestureRecognizer = CustomGestureRecognizer(target: self, action:#selector(ViewController.imageTapped(sender:)), url: url)
        cell?.imageView?.addGestureRecognizer(tapGesture)
        cell?.imageView?.isUserInteractionEnabled = true
        return cell!
        
    }
    
    func imageTapped(sender: CustomGestureRecognizer) {
        let url = sender.url
        self.openUrl(url: url)
    }
    
    
    func openUrl(url: String!){
    
        let targetURL=NSURL(string: url)
        
        let application=UIApplication.shared
        
        application.openURL(targetURL! as URL)
    }
   
}

