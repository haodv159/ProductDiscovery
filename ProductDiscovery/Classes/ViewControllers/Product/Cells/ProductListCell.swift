//
//  ProductListCell.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/10/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    static let heightCell = CGFloat(104)
    static let identifier = "ProductListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ data: Product) {
        nameLabel.text = data.name
        avatarImageView.sd_setImage(with: URL(string: data.images?.first?.url ?? ""), placeholderImage: #imageLiteral(resourceName: "avatar-default"))
        updatePrice(data)
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
