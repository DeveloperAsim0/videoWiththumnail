//
//  internet.swift
//  newVideo
//
//  Created by Mihir Vyas on 28/09/20.
//  Copyright © 2020 Mihir vyas. All rights reserved.
//

import UIKit
import Alamofire
struct Connectivity {
    static let shareInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool{
        return self.shareInstance.isReachable
    }
}
