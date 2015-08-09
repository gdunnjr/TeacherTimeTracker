//
//  TimeEntryTableViewCell.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/8/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class TimeEntryTableViewCell: PFTableViewCell {

    @IBOutlet weak var hoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
