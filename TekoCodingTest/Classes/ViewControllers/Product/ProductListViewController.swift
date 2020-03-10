//
//  ProductListViewController.swift
//  TekoCodingTest
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
        viewModel.getProductList("")
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
        
        addToolBar(textField: searchBar)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(4)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: ProductListCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductListCell.identifier)
    }
    
    private func bindViewModel() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        var foodItems = [Int]()
        for index in 0 ..< 10 {
            foodItems.append(index)
        }
        
        Observable.just(foodItems).bind(to: collectionView.rx.items(cellIdentifier: ProductListCell.identifier, cellType: ProductListCell.self)) { _, index, cell in
            cell.bindData("")
        }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.bind { indexPath in
        }.disposed(by: disposeBag)
    }

}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: ProductListCell.heightCell)
    }
}
