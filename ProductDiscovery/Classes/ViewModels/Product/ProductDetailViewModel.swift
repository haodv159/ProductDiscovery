//
//  ProductDetailViewModel.swift
//  ProductDiscovery
//
//  Created by Hao Dam Van on 3/11/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ProductDetailViewModel: BaseViewModel {
    
    var productId = ""
    var product = BehaviorRelay<Product>(value: Product())
    var products = BehaviorRelay<[Product]>(value: [Product]())
    
    var productIdNew = PublishSubject<String>()
    var currentPrice = Double(0)
    var productsCount = 0
    var totalPrice = Double(0)
    var totalProductsInCart = 0
    
    override init() {
        super.init()
    }
    
    func getProductDetail() {
        guard !productId.isEmpty else { return }
        let params = ["terminal": "CP01",
                      "channel": "pv_online"] as [String: Any]
        APIService.getDetail(productId, params).subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            if response.isSuccess {
                weakSelf.handleSuccess(response.result)
            }
        }).disposed(by: disposeBag)
    }
    
    private func handleSuccess(_ response: [String: Any]) {
        if let data = response["product"] as? [String: Any] {
            product.accept(Product(JSON(data)))
        }
    }
    
    // Fake data
    
    func getProductList() {
        let params = ["q": "",
            "terminal": "CP01",
            "visitorId": "",
            "channel": "pv_online",
            "_page": 1,
            "_limit": 20] as [String: Any]
        APIService.getList(params).subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            if response.isSuccess {
                weakSelf.handleGetListSuccess(response.result)
            }
        }).disposed(by: disposeBag)
    }
    
    private func handleGetListSuccess(_ response: [String: Any]) {
        if let data = response["products"] as? [[String: Any]] {
            let listProduct = data.map({ Product(JSON($0)) })
            products.accept(listProduct)
        }
    }
}

