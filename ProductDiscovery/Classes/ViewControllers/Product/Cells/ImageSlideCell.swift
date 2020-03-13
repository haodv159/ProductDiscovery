//
//  ImageSlideCell.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class ImageSlideCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    static let heightCell = CGFloat(327)
    static let identifier = "ImageSlideCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ data: Image) {
        avatarImageView.sd_setImage(with: URL(string: data.url ?? ""), placeholderImage: #imageLiteral(resourceName: "avatar-default"))
    }
    
}
