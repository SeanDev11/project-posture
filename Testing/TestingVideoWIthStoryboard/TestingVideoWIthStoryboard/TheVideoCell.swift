//
//  TheVideoCell.swift
//  TestingBackgroundVideo
//
//  Created by Sean Devine on 06.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

class TheVideoCell: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupPlayerCell(){
        self.layer.addSublayer(initialLayer)
    }
    
    
    let initialLayer: CALayer = {
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.green.cgColor
        return layer
        
    }()
    
    
    
}

class VideoCellCell: BaseCell {
    
    
    
    override func setupViews() {
        addSubview(lowerView)
        lowerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lowerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lowerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    let lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
       return view
    }()
    
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
