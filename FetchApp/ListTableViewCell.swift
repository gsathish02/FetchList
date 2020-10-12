//
//  ListTableViewCell.swift
//  FetchApp
//
//  Created by Sathish Kumar G on 10/9/20.
//  Copyright © 2020 Sathish Kumar G. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetupCell(item: ListItem) {
        self.textLabel?.text = item.name
    }

}
