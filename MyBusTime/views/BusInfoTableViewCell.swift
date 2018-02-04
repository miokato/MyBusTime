//
//  BusInfoTableViewCell.swift
//  MyBusTime
//
//  Created by mio kato on 2018/02/03.
//  Copyright © 2018 mio kato. All rights reserved.
//

import UIKit

class BusInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
