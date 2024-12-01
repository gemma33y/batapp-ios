//
//  NoteDetailViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
    }
    
    func updateContent(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
