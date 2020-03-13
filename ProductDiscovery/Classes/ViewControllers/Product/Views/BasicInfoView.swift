//
//  BasicInfoView.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BasicInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountImageView: UIImageView!
    
    static let height = CGFloat(126)
    private var disposeBag = DisposeBag()
    
    var product = BehaviorRelay<Product>(value: Product())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: BasicInfoView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        self.product.asObservable().subscribe(onNext: { [weak self] (product) in
            guard let weakSelf = self else { return }
            weakSelf.updateUI(product)
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(_ data: Product) {
        nameLabel.text = data.name
        productCodeLabel.text = data.sku
        statusLabel.text = data.status?.sale
        self.updatePrice(data)
    }
        
    private func updatePrice(_ data: Product) {
        let sellPrice = data.price?.sellPrice ?? 0
        let promotionPrices = data.price?.supplierSalePrice ?? 0
        let discount = data.discount
        
        let oldPrice = discount > 0 ? sellPrice.formattedWithDots : ""
        setAttributeForOldPrice(oldPrice)
        
        currentPriceLabel.text = promotionPrices.formattedWithDots
        discountLabel.text = discount > 0 ? "-\(discount)%" : ""
        discountImageView.isHidden = discount <= 0
    }
    
    private func setAttributeForOldPrice(_ text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        oldPriceLabel.attributedText = attributeString
    }
}
