//
//  ProductInfoViewModel.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ProductInfoViewModel: BaseViewModel {
    
    var attributeGroups = BehaviorRelay<[AttributeGroups]>(value: [AttributeGroups]())
    
    override init() {
        super.init()
    }
}
