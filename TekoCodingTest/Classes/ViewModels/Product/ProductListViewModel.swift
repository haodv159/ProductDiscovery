//
//  ProductListViewModel.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/10/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation

class ProductListViewModel: BaseViewModel {
    
    var page = 1
    
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
        }).disposed(by: disposeBag)
    }
}
