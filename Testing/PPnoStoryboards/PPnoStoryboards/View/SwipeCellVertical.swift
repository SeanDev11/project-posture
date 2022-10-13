//
//  SwipeCellVerticle.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 20.11.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

protocol SwipeCellVerticalDelegate: class {
    func visibleContainerViewTappedVertical(inCell cell: UICollectionViewCell)
    func hiddenContainerViewTappedVertical(inCell cell: UICollectionViewCell)
    func cancelViewTappedVertical(inCell cell: UICollectionViewCell)
}

class SwipeCellVertical: UICollectionViewCell {
    
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
    
    weak var delegate: SwipeCellVerticalDelegate?
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToLeftVertical() {
        let originPoint: CGPoint = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(originPoint, animated: true)
    }
    
    
    
    
    private func setupSubviews() {
        let screenW = UIScreen.main.bounds.width
        let stackView = UIStackView()
        hiddenContainerView.addSubview(deleteView)
        hiddenContainerView.addSubview(cancelView)
        hiddenContainerView.widthAnchor.constraint(equalToConstant: screenW * 0.3).isActive = true
        stackView.axis = .horizontal
        
        stackView.distribution = .fill
        stackView.addArrangedSubview(visibleContainerView)
        stackView.addArrangedSubview(hiddenContainerView)
        
        stackView.spacing = 0
        addSubview(scrollView)
        scrollView.pinEdgesToSuperView()
        scrollView.addSubview(stackView)
        stackView.pinEdgesToSuperView()
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.3).isActive = true
    }
    
    private func setupGestureRecognizer() {
        let hiddenContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenContainerViewTappedVertical))
        deleteView.addGestureRecognizer(hiddenContainerTapGestureRecognizer)
        
        let visibleContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(visibleContainerViewTappedVertical))
        visibleContainerView.addGestureRecognizer(visibleContainerTapGestureRecognizer)
        
        let cancelViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelViewTappedVertical))
        
        cancelView.addGestureRecognizer(cancelViewTapGestureRecognizer)
        
    }
    
    @objc private func visibleContainerViewTappedVertical() {
        delegate?.visibleContainerViewTappedVertical(inCell: self)
    }
    
    @objc private func hiddenContainerViewTappedVertical() {
        delegate?.hiddenContainerViewTappedVertical(inCell: self)
    }
    
    @objc private func cancelViewTappedVertical() {
        delegate?.cancelViewTappedVertical(inCell: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // when the orientation changes and the cell is open -> update the content offset for the new cell width
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = scrollView.frame.width
        }
    }
}
