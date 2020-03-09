//
//  BaseRequest.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Alamofire
import RxSwift

class BaseRequest: URLRequestConvertible {

    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    var parameters: [String: Any]? {
        return [String: Any]()
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = urlRequestWithHeaders()
        if method == .get {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        printURLPretty(urlRequest)
        return urlRequest
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    func urlRequestWithHeaders() -> URLRequest {
        let url = URL(string: Address.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        urlRequest.allHTTPHeaderFields = headers
        print("========= HEADERS: \(String(describing: urlRequest.allHTTPHeaderFields))")
        return urlRequest
    }
    
    func printURLPretty(_ urlRequest: URLRequest?) {
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        print("Parameters: \(String(describing: parameters))")
        if let jsonBody = urlRequest?.httpBody {
            print("JSON: \(String(describing: String(data: jsonBody, encoding: .utf8)))")
        }
        print("URL: \(String(describing: urlRequest?.url?.absoluteString))")
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    }
}
