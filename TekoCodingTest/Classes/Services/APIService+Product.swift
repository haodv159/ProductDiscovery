//
//  APIService+Product.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire

class ProductRouter: BaseRequest {
    
    enum EndPoint {
        case list([String: Any])
        case detail([String: Any])
    }
    
    var endPoint: EndPoint
    
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
        case .list:
            return .get
        case .detail:
            return .get
        }
    }
    
    override var parameters: [String: Any]? {
        switch endPoint {
        case .list(let param):
            return param
        case .detail(let param):
            return param
        }
    }

    override var path: String {
        switch endPoint {
        case .list:
            return Address.Product.list
        case .detail:
            return Address.Product.detail
        }
    }
    
    override func asURLRequest() throws -> URLRequest {
        var urlRequest = urlRequestWithHeaders()
        urlRequest.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        printURLPretty(urlRequest)
        
        return urlRequest
    }
}

extension APIService {
    
    static func getList(_ param: [String: Any]) -> Observable<APIResponse> {
        return request(ProductRouter(endPoint: .list(param)))
    }
}


