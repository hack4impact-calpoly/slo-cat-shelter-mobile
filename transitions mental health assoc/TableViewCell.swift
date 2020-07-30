//
//  TableViewCell.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 7/30/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
