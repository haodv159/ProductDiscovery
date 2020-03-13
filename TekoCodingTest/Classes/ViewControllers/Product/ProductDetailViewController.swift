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
    @IBOutlet weak var productsView: ProductsView!
    @IBOutlet weak var detailInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productsChoosedLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalProductInCartLabel: UILabel!
    
    var viewModel = ProductDetailViewModel()
    
    private var isExpandView = BehaviorRelay<Bool>(value: false)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindViewModel()
        viewModel.getProductList()
        loadDataDetail()
    }
    
    private func updateUI() {
        contentViewHeightConstraint.constant = SlideView.height + BasicInfoView.height + detailInfoHeightConstraint.constant + ProductsView.height
    }
    
    private func reloadUI() {
        detailInfoView.isExpandView.accept(false)
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    private func loadDataDetail() {
        LoadingIndicator.shared.showAdd(to: self.view, animated: true)
        viewModel.getProductDetail()
    }
    
    private func loadDataBegin(_ product: Product) {
        nameNavLabel.text = product.name ?? ""
        
        let promotionPrices = product.price?.supplierSalePrice ?? 0
        priceNavLabel.text = "\(promotionPrices.formattedWithDots) đ"
        
        viewModel.currentPrice = promotionPrices

        resetDataForCart()
    }
    
    private func bindViewModel() {
        viewModel.product.asObservable().subscribe(onNext: { [weak self] product in
            guard let weakSelf = self else { return }
            LoadingIndicator.shared.hide(for: self?.view)
            weakSelf.reloadUI()
            weakSelf.loadDataBegin(product)
            weakSelf.setImageForSlide(product)
            weakSelf.setDataBasicInfo(product)
            weakSelf.setDataDetailInfo(product)
        }).disposed(by: disposeBag)
        
        detailInfoView.isExpandView.asObservable().subscribe(onNext: { [weak self] status in
            guard let weakSelf = self else { return }
            weakSelf.detailInfoHeightConstraint.constant = status ? CGFloat(500) : DetailInfoView.height
            weakSelf.updateUI()
        }).disposed(by: disposeBag)
        
        viewModel.productIdNew.asObservable().subscribe(onNext: { [weak self] value in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.productId = value
            weakSelf.loadDataDetail()
        }).disposed(by: disposeBag)
        
        viewModel.products.bind(to: self.productsView.products).disposed(by: disposeBag)
        productsView.productIdNew.bind(to: viewModel.productIdNew).disposed(by: disposeBag)
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
    
    private func loadUIForCart() {
        productsChoosedLabel.text = String(viewModel.productsCount)
        totalPriceLabel.text = "\(viewModel.totalPrice.formattedWithDots) đ"
        totalProductInCartLabel.text = String(viewModel.totalProductsInCart)
    }
    
    private func resetDataForCart() {
        viewModel.productsCount = 0
        viewModel.totalPrice = 0
        
        loadUIForCart()
    }
    
    private func confirmAddToCart() {
        let alert = UIAlertController(title: "Product Discovery", message: "Bạn có muốn thêm sản phẩm vào giỏ hàng?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.totalProductsInCart += 1
            weakSelf.resetDataForCart()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func singleAlert(_ message: String) {
        let alert = UIAlertController(title: "Product Discovery", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Actions
    
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onRemoveProductButton(_ sender: Any) {
        guard viewModel.productsCount > 0 else {
            singleAlert("Số lượng sản phẩm không đúng định dạng")
            return
        }
        viewModel.productsCount -= 1
        viewModel.totalPrice -= viewModel.currentPrice
        loadUIForCart()
    }
    
    @IBAction func onAddProductButton(_ sender: Any) {
        guard viewModel.productsCount < 10 else {
            singleAlert("Số lượng sản phẩm vượt quá mức quy định")
            return
        }
        viewModel.productsCount += 1
        viewModel.totalPrice += viewModel.currentPrice
        loadUIForCart()
    }
    
    @IBAction func onAddCartButton(_ sender: Any) {
        guard viewModel.productsCount > 0 else {
            singleAlert("Bạn chưa chọn số lượng")
            return
        }
        confirmAddToCart()
    }
    
    @IBAction func onCartButton(_ sender: Any) {
        singleAlert("Tính năng đang được phát triển")
    }
}
