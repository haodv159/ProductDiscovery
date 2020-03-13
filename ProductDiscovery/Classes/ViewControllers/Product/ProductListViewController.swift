//
//  ProductListViewController.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/10/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: BaseViewController {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        bindViewModel()
        viewModel.reload(searchBar.text ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    private func setupSearchBar() {
        searchBar.returnKeyType = .search
        searchBar.autocorrectionType = .no
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        leftView.backgroundColor = UIColor.clear
        
        let searchIcon = UIImageView(image: #imageLiteral(resourceName: "search"))
        searchIcon.center = CGPoint(x: leftView.bounds.midX, y: leftView.bounds.midY)
        leftView.addSubview(searchIcon)
        
        searchBar.leftView = leftView
        searchBar.leftViewMode = .always
        searchBar.clearButtonMode = .whileEditing
        
        searchBar.delegate = self
        
        addToolBar(textField: searchBar)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(4)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: ProductListCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductListCell.identifier)
    }
    
    private func bindViewModel() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.products.bind(to: collectionView.rx.items(cellIdentifier: ProductListCell.identifier, cellType: ProductListCell.self)) { _, data, cell in
            cell.bindData(data)
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Product.self).bind { [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.showProductDetailScreen(data.sku ?? "")
        }.disposed(by: disposeBag)
        
        collectionView.addPullToRefresh { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.reload(weakSelf.searchBar.text ?? "")
        }
        
        collectionView.addInfiniteScrollingView { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.loadMore(weakSelf.searchBar.text ?? "")
        }
        
        viewModel.products.asObservable().subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.collectionView.stopPullToRefreshAnimating()
            weakSelf.collectionView.infiniteScrollingView?.stopAnimating()
        }).disposed(by: disposeBag)
    }

    // MARK: - Navigation
    
    private func showProductDetailScreen(_ productId: String) {
        let productDetailVC = self.instantiateViewController(fromStoryboard: .product, ofType: ProductDetailViewController.self)
        productDetailVC.viewModel.productId = productId
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: ProductListCell.heightCell)
    }
}

extension ProductListViewController: UITextFieldDelegate {

    func addToolBar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Xong", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(){
        view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.getProductList(textField.text ?? "")
    }
}
