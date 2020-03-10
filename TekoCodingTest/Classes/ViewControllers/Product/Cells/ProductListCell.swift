//
//  ProductListCell.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/10/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    static let heightCell = CGFloat(104)
    static let identifier = "ProductListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ data: String) {
        
    }
}
