//
//  APIConfigs.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

struct Address {
    
    static let domain = "listing.stage.tekoapis.net"
    static let baseUrl = "https://\(domain)/"
    
    struct Product {
        static let list     = "api/search"
        static let detail   = "api/products"
    }
}
