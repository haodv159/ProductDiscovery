//
//  ProductInfoViewController.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductInfoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ProductInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isScrollEnabled = false
    }
    
    private func bindViewModel() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.attributeGroups.bind(to: tableView.rx.items(cellIdentifier: ProductInfoCell.identifier, cellType: ProductInfoCell.self)) { _, data, cell in
            cell.bindData(data, isEvenNumber: true)
        }.disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ProductInfoViewController: UITableViewDelegate {
    
}
