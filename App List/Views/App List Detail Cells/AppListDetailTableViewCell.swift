//
//  AppListDetailTableViewCell.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

class AppListDetailTableViewCell: UITableViewCell {

    let infoLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInfoLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
            ])
        
        infoLabel.font = UIFont(name: "Avenir-Medium", size: 18.0)
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
    }
}
