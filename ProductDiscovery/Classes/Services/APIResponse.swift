//
//  APIResponse.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON
import MBProgressHUD

struct APIResponse {
    
    var isSuccess: Bool = false
    var message: String = ""
    var result = [String: Any]()
    var extra = [String: Any]()
    
    static var errorAlertResponse = PublishSubject<Bool>()
    
    init(_ response: DataResponse<Any>) {
        print("RESULTS: \(String(describing: response.result.value))")
        if let value = response.result.value as? [String: Any] {
            if let message = value["message"] as? String {
                self.message = message
            }
            
            if let code = value["code"] as? String {
                self.isSuccess = code == "SUCCESS"
            }
            
            if let result = value["result"] as? [String: Any] {
                self.result = result
            }
            
            if let extra = value["extra"] as? [String: Any] {
                self.extra = extra
            }
        }
    }
    
    init(_ error: Error) {
        print("Error code: \((error as NSError).code)")
    }
}
