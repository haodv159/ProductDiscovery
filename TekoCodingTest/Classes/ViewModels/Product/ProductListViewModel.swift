//
//  ProductListViewModel.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/10/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ProductListViewModel: BaseViewModel {
    
    var page = 1
    var products = BehaviorRelay<[Product]>(value: [Product]())
    
    override init() {
        super.init()
    }
    
    func getProductList(_ searchText: String) {
        let params = ["q": "\(searchText)",
            "terminal": "CP01",
            "visitorId": "",
            "channel": "pv_online",
            "_page": page,
            "_limit": 20] as [String: Any]
        APIService.getList(params).subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            print("TestTest: \(response)")
            if response.isSuccess {
                weakSelf.handleSuccess(response.data)
            }
        }).disposed(by: disposeBag)
    }
    
    private func handleSuccess(_ response: [[String: Any]]) {
        let listProduct = response.map({ Product(JSON($0)) })//.filter({ $0.status?.isPublish == true })
        products.accept(listProduct)
    }
}
