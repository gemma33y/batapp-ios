//
//  ImageTableViewCell.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 27/10/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCustom: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

