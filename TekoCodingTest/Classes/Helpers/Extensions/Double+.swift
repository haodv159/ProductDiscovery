//
//  Double+.swift
//  TekoCodingTest
//
//  Created by Hao Dam Van on 3/13/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation

extension Double {
    
    var formattedWithDots: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
