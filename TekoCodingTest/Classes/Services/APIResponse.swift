//
//  APIResponse.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON
import MBProgressHUD

enum APIStatus: Int {
    case success = 0
    case failed = 1
    case error = 2
    case none = 3
    
    static func rawValue(_ value: Int) -> APIStatus {
        switch value {
        case 0: return .success
        case 1: return .failed
        case 2: return .error
        case 3: return .none
        default: return .none
        }
    }
}

struct APIResponse {
    
    var isSuccess: Bool = false
    var message: String = ""
    var data = [[String: Any]]()
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
            
            if let dict = value["result"] as? [String: Any],
                let data = dict["products"] as? [[String: Any]] {
                self.data = data
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
