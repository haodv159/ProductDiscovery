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
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel = ProductInfoViewModel()
    var heightView = PublishSubject<CGFloat>()
    private var heightTableView = CGFloat(150)
    
    private let heightCell = CGFloat(35)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heightView.onNext(getHeightView())
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isScrollEnabled = false
    }
    
    private func bindViewModel() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.attributeGroups.bind(to: tableView.rx.items(cellIdentifier: ProductInfoCell.identifier, cellType: ProductInfoCell.self)) { index, data, cell in
            let isEvenNumber = index % 2 == 0
            cell.bindData(data, isEvenNumber)
        }.disposed(by: disposeBag)
        
        viewModel.attributeGroups.asObservable().subscribe(onNext: { [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.setHeightTableView()
        }).disposed(by: disposeBag)
    }
    
    private func setHeightTableView() {
        heightTableView = CGFloat(viewModel.attributeGroups.value.count) * heightCell
        tableViewHeightConstraint.constant = heightTableView
    }
    
    private func getHeightView() -> CGFloat {
        return heightTableView + 106
    }
}

// MARK: - UITableViewDelegate

extension ProductInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}
