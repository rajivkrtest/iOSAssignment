//
//  HomeTableViewCell.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let imageViewFeed:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        img.backgroundColor = UIColor.clear
        img.contentMode = UIView.ContentMode.scaleAspectFill
        return img
    }()
    
    let labelText:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let labelDescription:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageViewFeed)
        contentView.addSubview(labelText)
        contentView.addSubview(labelDescription)
        
        let marginGuide = contentView.layoutMarginsGuide
        self.imageViewFeed.topAnchor.constraint(equalTo:marginGuide.topAnchor).isActive = true
        self.imageViewFeed.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor).isActive = true
        self.imageViewFeed.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true
        self.imageViewFeed.heightAnchor.constraint(equalToConstant:300).isActive = true
        
        self.labelText.topAnchor.constraint(equalTo:self.imageViewFeed.bottomAnchor).isActive = true
        self.labelText.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor).isActive = true
        self.labelText.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true

        self.labelDescription.topAnchor.constraint(equalTo:self.labelText.bottomAnchor).isActive = true
        self.labelDescription.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor).isActive = true
        self.labelDescription.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true
        self.labelDescription.bottomAnchor.constraint(equalTo:marginGuide.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
}
