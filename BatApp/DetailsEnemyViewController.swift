//
//  DetailsEnemyViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 27/10/24.
//

import UIKit

class DetailsEnemyViewController: UIViewController {

    @IBOutlet weak var imageEnemy: UIImageView!

    @IBOutlet weak var nameEnemy: UILabel!
    
    @IBOutlet weak var descriptionEnemy: UILabel!
    
    
    // Properties to receive data
    var nameEnemyText: String?
    var imageEnemyImage: UIImage?
    var descriptionEnemyText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameEnemy.text = nameEnemyText
        imageEnemy.image = imageEnemyImage
        descriptionEnemy.text = descriptionEnemyText
    }
    

}
