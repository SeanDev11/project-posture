//
//  VideoCell.swift
//  youtube
//
//  Created by Sean Devine on 06.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import UIKit

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



class VideoCell: BaseCell {
    
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            
            
            
            
            if let channelName = video?.channel?.name, let numberViews = video?.numOfViews {
          
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let formattedViews = numberFormatter.string(from: numberViews)
                
                let subtitleText = "\(channelName) • \(formattedViews ?? "0") • 2 years ago"
                
                subtitleTextView.text = subtitleText
            }
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: (frame.width - 84), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
//            HEIGHT CONSTRAINT CONSTANT
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                    
                }else {
                    titleLabelHeightConstraint?.constant = 20
                }
                
            }
            
           
            
    }
    }
    
   func setupThumbnailImage() {
    if let thumbnailImageUrl = video?.thumbnailImageName {
        
        thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)

        }
    }
    
   func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profileImageName {
        userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
    
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,647,202 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        //Horizontal Constraints Image View Thumbnail
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        
        //Vertical Constraints Image View Thumbnail
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        
        //Horizontal Constraints Seperator View
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
        
        //Vertical Constraints Seperator View
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(2)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
        
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(2)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
        
        
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //top constraint label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        
        //left constraint label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height
        
        
//   ADD HEIGHT CONSTRAINT WITH VARIABLE CONSTANT
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40)
        
        addConstraint(titleLabelHeightConstraint!)
        
        //subtitle
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top
            , relatedBy: .equal
            , toItem: titleLabel, attribute: .bottom
            , multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant:  0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    
    
    
}



