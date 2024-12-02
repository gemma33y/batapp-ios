//
//  NoteTableViewCell.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
