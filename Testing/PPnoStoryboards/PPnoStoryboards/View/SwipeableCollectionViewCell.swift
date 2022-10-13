//
//  SwipeableCollectionViewCell.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 19.11.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

protocol SwipeableCollectionViewCellDelegate: class {
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell)
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell)
    func cancelViewTapped(inCell cell: UICollectionViewCell)
}

class SwipeableCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let deleteView: UIView = {
        let del = UIView()
        del.translatesAutoresizingMaskIntoConstraints = false
        del.backgroundColor = UIColor.green
        return del
    }()
    
    let cancelView: UIView = {
        let cancel = UIView()
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.backgroundColor = UIColor.blue
        return cancel
    }()
    
    let visibleContainerView = UIView()
    let hiddenContainerView = UIView()
    
    weak var delegate: SwipeableCollectionViewCellDelegate?
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToLeft() {
        let originPoint: CGPoint = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(originPoint, animated: true)
    }
    
    func scrollToLeftNonAnimated() {
        let originPoint: CGPoint = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(originPoint, animated: false)
    }
    
    
    
    private func setupSubviews() {
        
        let stackView = UIStackView()
        hiddenContainerView.addSubview(deleteView)
        hiddenContainerView.addSubview(cancelView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(visibleContainerView)
        stackView.addArrangedSubview(hiddenContainerView)
        
        
        addSubview(scrollView)
        scrollView.pinEdgesToSuperView()
        scrollView.addSubview(stackView)
        stackView.pinEdgesToSuperView()
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2).isActive = true
    }
    
    private func setupGestureRecognizer() {
        let hiddenContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
        deleteView.addGestureRecognizer(hiddenContainerTapGestureRecognizer)
        
        let visibleContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(visibleContainerViewTapped))
        visibleContainerView.addGestureRecognizer(visibleContainerTapGestureRecognizer)
        
        let cancelViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelViewTapped))
        
        cancelView.addGestureRecognizer(cancelViewTapGestureRecognizer)
        
    }
    
    @objc private func visibleContainerViewTapped() {
        delegate?.visibleContainerViewTapped(inCell: self)
    }
    
    @objc private func hiddenContainerViewTapped() {
        
        delegate?.hiddenContainerViewTapped(inCell: self)
    }
    
    @objc private func cancelViewTapped() {
        delegate?.cancelViewTapped(inCell: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // when the orientation changes and the cell is open -> update the content offset for the new cell width
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = scrollView.frame.width
        }
    }
}
