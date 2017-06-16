//
//  PostTableViewCell.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 6/16/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var titleLable : UILabel!
    @IBOutlet var bodyLable : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
