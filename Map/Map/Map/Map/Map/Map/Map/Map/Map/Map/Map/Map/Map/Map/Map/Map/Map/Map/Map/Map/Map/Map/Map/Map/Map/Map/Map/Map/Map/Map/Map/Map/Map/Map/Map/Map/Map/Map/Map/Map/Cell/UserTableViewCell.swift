//
//  UserTableViewCell.swift
//  Map
//
//  Created by may985 on 7/13/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var labelEmail: UILabel!

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
