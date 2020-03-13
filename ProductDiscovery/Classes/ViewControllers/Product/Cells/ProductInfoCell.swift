//
//  ProductInfoCell.swift
//  ProductDiscovery
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier = "ProductInfoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ data: AttributeGroups, _ isEvenNumber: Bool) {
        titleLabel.text = data.name
        valueLabel.text = data.value
        self.backgroundColor = isEvenNumber ? .paleGrey : .white
    }
}
