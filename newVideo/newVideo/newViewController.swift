//
//  newViewController.swift
//  newVideo
//
//  Created by Mihir Vyas on 28/09/20.
//  Copyright © 2020 Mihir vyas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Network

class newViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        if Connectivity.isConnectedToInternet {
//            api()
//        } else {
//            print("No internet")
//        }
       // moit()
        api()

        
    }
    
    func moit(){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                DispatchQueue.main.async {
                    self.view.backgroundColor = .green
                }
                
            } else {
                DispatchQueue.main.async {
                     self.view.backgroundColor = .red
                }
                
               
            }
            
        }
        
        let que = DispatchQueue(label: "Network")
        monitor.start(queue: que)
    }
    
    
    func api(){
        let url = "http://3.15.167.54:8117/offers_list"
        let params : [String: Any] = ["keywords" : ""]
        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default).responseJSON { (responseq) in
            switch responseq.result {
            case .success :
                print(responseq.result)
                break
            case.failure :
                print(responseq.error.debugDescription)
            }
        }
    }

   

}
