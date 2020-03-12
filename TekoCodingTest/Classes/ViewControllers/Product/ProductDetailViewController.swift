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
    
    @IBOutlet weak var nameNavLabel: UILabel!
    @IBOutlet weak var priceNavLabel: UILabel!
    @IBOutlet weak var slideView: SlideView!
    @IBOutlet weak var basicInfoView: BasicInfoView!
    @IBOutlet weak var detailInfoView: DetailInfoView!
    @IBOutlet weak var detailInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel = ProductDetailViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.getProductDetail()
    }
    
    private func setupUI() {
        detailInfoHeightConstraint.constant = CGFloat(500)
        contentViewHeightConstraint.constant = SlideView.height + BasicInfoView.height + detailInfoHeightConstraint.constant + 282
    }
    
    private func bindViewModel() {
        viewModel.product.asObservable().subscribe(onNext: { [weak self] product in
            guard let weakSelf = self else { return }
            weakSelf.setImageForSlide(product)
            weakSelf.setDataBasicInfo(product)
            weakSelf.setDataDetailInfo(product)
        }).disposed(by: disposeBag)
    }
    
    private func setImageForSlide(_ product: Product) {
        if let images = product.images {
            slideView.images.accept(images.isEmpty ? [Image()] : images)
        } else {
            slideView.images.accept([Image()])
        }
    }
    
    private func setDataBasicInfo(_ product: Product) {
        basicInfoView.product.accept(product)
    }
    
    private func setDataDetailInfo(_ product: Product) {
        detailInfoView.product.accept(product)
    }

    // MARK: - Actions
    
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
