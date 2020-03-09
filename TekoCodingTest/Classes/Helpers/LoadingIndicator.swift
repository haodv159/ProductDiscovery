//
//  LoadingIndicator.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoadingIndicator: NSObject {
    static let shared = LoadingIndicator()
    
    func showAdd(to view: UIView, animated: Bool = true) {
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    func hide(for view: UIView?, animated: Bool = true) {
        guard let view = view else { return }
        MBProgressHUD.hide(for: view, animated: true)
    }
}
