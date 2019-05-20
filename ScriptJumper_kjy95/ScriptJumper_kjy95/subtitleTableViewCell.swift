//
//  subtitleTableViewCell.swift
//  ScriptJumper_kjy95
//
//  Created by 김지영 on 16/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class subtitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
