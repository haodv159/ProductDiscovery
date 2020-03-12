//
//  DetailInfoView.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Parchment
import SnapKit

enum ProductInfo: Int {
    case description
    case specifications
    case priceComparing
    
    static var count: Int {
        return ProductInfo.priceComparing.rawValue + 1
    }
    
    var title: String {
        switch self {
        case .description:
            return "Mô tả sản phẩm"
        case .specifications:
            return "Thông số kỹ thuật"
        case .priceComparing:
            return "So sánh giá"
        }
    }
}

class DetailInfoView: UIView {

    @IBOutlet var contentView: UIView!
    
    static let height = CGFloat(238)
    private var disposeBag = DisposeBag()
    
    var product = BehaviorRelay<Product>(value: Product())
    
    private lazy var pagingViewController: PagingViewController<PagingIndexItem> = {
        let controller = PagingViewController<PagingIndexItem>()
        controller.font = UIFont.regularDesignFont(ofSize: 13)
        controller.selectedFont = UIFont.regularDesignFont(ofSize: 13)
        controller.textColor = .coolGrey
        controller.selectedTextColor = .darkGrey
        controller.indicatorColor = .reddishOrange
        controller.dataSource = self
        controller.delegate = self
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: DetailInfoView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        self.setupViews()
        self.bindViewModel()
    }
    
    private func setupViews() {
        self.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        self.product.asObservable().subscribe(onNext: { [weak self] (product) in
            guard let weakSelf = self else { return }
            weakSelf.pagingViewController.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - PagingViewControllerDataSource

extension DetailInfoView: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return PagingIndexItem(index: index, title: ProductInfo.init(rawValue: index)?.title ?? "") as! T
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        let vc = UIViewController().topController().instantiateViewController(fromStoryboard: .product, ofType: ProductInfoViewController.self)
        vc.viewModel.attributeGroups.accept(product.value.attributeGroups ?? [AttributeGroups]())
        return vc
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return ProductInfo.count
    }
}

// MARK: - PagingViewControllerDelegate

extension DetailInfoView: PagingViewControllerDelegate {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
        guard let item = pagingItem as? PagingIndexItem else { return 0 }

        let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
        let attributes = [NSAttributedString.Key.font: pagingViewController.font]
        
        let rect = item.title.boundingRect(with: size,
                                           options: .usesLineFragmentOrigin,
                                           attributes: attributes,
                                           context: nil)

        let width = ceil(rect.width) + insets.left + insets.right
        
        return min(width, self.bounds.width - 2 * 20)
    }
  
}
