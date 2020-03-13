//
//  ProductListViewModel.swift
//  ProductDiscovery
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
    var currentProducts = [Product]()
    var products = BehaviorRelay<[Product]>(value: [Product]())
    
    private var searchString = ""
    
    override init() {
        super.init()
    }
    
    private func resetData() {
        currentProducts = [Product]()
        page = 1
    }
    
    func reload(_ searchText: String ) {
        resetData()
        getProductList(searchText)
    }
    
    func loadMore(_ searchText: String) {
        page += 1
        getProductList(searchText)
    }
    
    private func handleDataBeforeUpdate(_ searchText: String) {
        if searchString != searchText {
            resetData()
            searchString = searchText
        }
    }
    
    func getProductList(_ searchText: String) {
        self.handleDataBeforeUpdate(searchText)
        let params = ["q": "\(searchText)",
            "terminal": "CP01",
            "visitorId": "",
            "channel": "pv_online",
            "_page": page,
            "_limit": 20] as [String: Any]
        APIService.getList(params).subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            if response.isSuccess {
                weakSelf.handleSuccess(response.result)
            }
        }).disposed(by: disposeBag)
    }
    
    private func handleSuccess(_ response: [String: Any]) {
        if let data = response["products"] as? [[String: Any]] {
            let listProduct = data.map({ Product(JSON($0)) })//.filter({ $0.status?.isPublish == true })
            currentProducts += listProduct
            products.accept(currentProducts)
        }
    }
}
