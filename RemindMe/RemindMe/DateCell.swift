//
//  DateCell.swift
//  RemindMe
//
//  Created by Sammy Torres II on 11/22/22.
//

import UIKit

class DateCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
