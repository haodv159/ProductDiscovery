//
//  SlideView.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/12/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SlideView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    static let height = CGFloat(327)
    private var disposeBag = DisposeBag()
    
    var images = BehaviorRelay<[Image]>(value: [Image]())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: SlideView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        setupCollectionView()
        setupSlide()
        bindViewModel()
    }
    
    private func setupSlide() {
        pageControl.currentPage = 0
        self.bringSubviewToFront(pageControl)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(0)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: ImageSlideCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageSlideCell.identifier)
    }
    
    private func bindViewModel() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.images.map({ $0.count }).bind(to: pageControl.rx.numberOfPages).disposed(by: disposeBag)
        
        self.images.bind(to: collectionView.rx.items(cellIdentifier: ImageSlideCell.identifier, cellType: ImageSlideCell.self)) { _, data, cell in
            cell.bindData(data)
        }.disposed(by: disposeBag)
        
        collectionView.rx.contentOffset.bind { [weak self] point in
            guard let weakSelf = self else { return }
            weakSelf.setCurrentPageControl(point)
        }.disposed(by: disposeBag)
    }
    
    private func setCurrentPageControl(_ point: CGPoint) {
        guard self.frame.width > 0 else { return }
        let scrollPos = point.x / self.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SlideView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: ImageSlideCell.heightCell)
    }
}
