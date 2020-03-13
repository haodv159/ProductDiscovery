//
//  UIViewController+.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case product = "Product"
}

extension UIViewController {
    
//    func showLoading(message: String = "", isShowMask: Bool = false) {
//        if isShowMask {
//            SVProgressHUD.setDefaultMaskType(.clear)
//        }
//        if !message.isEmpty {
//            SVProgressHUD.show(withStatus: message)
//        } else {
//            SVProgressHUD.show()
//        }
//    }
//
//    @objc func dismissLoading() {
//        SVProgressHUD.dismiss()
//    }
}

extension UIViewController {
    
    func topController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topController(controller: presented)
        }
        return controller ?? UIViewController()
    }
}

extension UIViewController {
    
    func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
}
