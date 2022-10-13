//
//  Extensions.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 18.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
}


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}


extension UILabel {
    
    var lineHeight: CGFloat {
        set {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = newValue
            paragraphStyle.maximumLineHeight = newValue
            _setAttribute(key: NSAttributedString.Key.paragraphStyle, value: paragraphStyle)
        }
        get {
            let paragraphStyle = _getAttribute(key: NSAttributedString.Key.paragraphStyle) as? NSParagraphStyle
            return paragraphStyle?.minimumLineHeight ?? 0
        }
    }
    
    func _getAttribute(key: NSAttributedString.Key) -> Any? {
        return attributedText?.attribute(key, at: 0, effectiveRange: .none)
    }
    
    func _setAttribute(key: NSAttributedString.Key, value: Any) {
        let attributedString: NSMutableAttributedString!
        if let currentAttrString = attributedText {
            attributedString = NSMutableAttributedString(attributedString: currentAttrString)
        } else {
            attributedString = NSMutableAttributedString(string: text ?? "")
            text = nil
        }
        attributedString.addAttribute(key,
                                      value: value,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
}



extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
