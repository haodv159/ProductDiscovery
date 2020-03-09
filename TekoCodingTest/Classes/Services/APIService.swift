//
//  APIService.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

struct APIService {
    
    static func request(_ urlRequest: BaseRequest) -> Observable<APIResponse> {
        return requestHTTPS(urlRequest)
    }

    static func requestHTTPS(_ urlRequest: BaseRequest) -> Observable<APIResponse> {
        return Observable.create({ observer in
            _ = SessionManager.rx.request(urlRequest: urlRequest).responseJSON().subscribe(onNext: { response in
                observer.onNext(APIResponse(response))
                observer.onCompleted()
            }, onError: { error in
                _ = APIResponse(error)
                observer.onError(error)
            })
            
            return Disposables.create()
        })
    }
    
    static let SessionManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [Address.domain: .disableEvaluation]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return man
    }()
}
