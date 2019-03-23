//
//  CustomCellControllerTableViewCell.swift
//  JSQMessage
//
//  Created by 廣瀬由明 on 2019/03/15.
//  Copyright © 2019 廣瀬由明. All rights reserved.
//

import UIKit

class CustomCellController: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var textTextLabel: UILabel!
    
    

}
