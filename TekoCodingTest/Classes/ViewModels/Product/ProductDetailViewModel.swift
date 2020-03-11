//
//  ProductDetailViewModel.swift
//  TekoCodingTest
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
    
    override init() {
        super.init()
    }
    
    func getProductDetail() {
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
}

