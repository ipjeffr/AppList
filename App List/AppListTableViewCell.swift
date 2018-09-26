//
//  AppListTableViewCell.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

class AppListTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
    func update(with image: UIImage?) {
        if let image = image {
            UIView.animate(withDuration: 0.5, animations: {
                self.iconImageView.alpha = 1.0
                self.iconImageView.image = image
            })
        } else {
            iconImageView.alpha = 0.0
            iconImageView.image = nil
        }
    }
}
