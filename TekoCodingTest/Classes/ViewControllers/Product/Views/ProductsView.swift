//
//  ProductsView.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/13/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    static let height = CGFloat(282)
    private var disposeBag = DisposeBag()

    var products = BehaviorRelay<[Product]>(value: [Product]())
    var productIdNew = PublishSubject<String>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: ProductsView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        self.setupCollectionView()
        self.bindViewModel()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(12)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        collectionView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    private func bindViewModel() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
       
        self.products.bind(to: collectionView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { _, data, cell in
            cell.bindData(data)
        }.disposed(by: disposeBag)
       
        collectionView.rx.modelSelected(Product.self).bind { [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.productIdNew.onNext(data.sku ?? "")
        }.disposed(by: disposeBag)
    }
}

extension ProductsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ProductCell.widthCell, height: ProductCell.heightCell)
    }
}
