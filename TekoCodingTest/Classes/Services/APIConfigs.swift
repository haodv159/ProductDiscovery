//
//  APIConfigs.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

struct Address {
    
    static let baseUrl = "https://listing.stage.tekoapis.net/"
    
    struct Product {
        static let list     = "api/search"
        static let detail   = "api/products"
    }
}
