//
//  ProductDetailViewController.swift
//  TekoCodingTest
//
//  Created by Hao Dam Van on 3/11/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: BaseViewController {
    
    var viewModel = ProductDetailViewModel()
    
    @IBOutlet weak var nameNavLabel: UILabel!
    @IBOutlet weak var priceNavLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProductDetail()
    }

    // MARK: - Actions
    
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
