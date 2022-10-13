//
//  customCell.swift
//  tableViewNewest
//
//  Created by Sean Devine on 02.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    
    
    @IBOutlet weak var targetAreas: UILabel!
    
    
    @IBOutlet weak var currentSelection: UILabel!
    
    @IBOutlet weak var configWorkout: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
