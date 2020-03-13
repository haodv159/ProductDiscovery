//
//  Int+.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/11/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation

extension Int {
    
    var formattedWithDots: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Formatter {

    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}
