//
//  TextTableViewCell.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 27/10/24.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textCustom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
