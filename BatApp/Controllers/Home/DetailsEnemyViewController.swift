//
//  DetailsEnemyViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 27/10/24.
//

import UIKit
import SDWebImage

class DetailsEnemyViewController: UIViewController {


    @IBOutlet weak var tableDetails: UITableView!
    
    
    // Properties to receive data
    var nameCharacterText: String?
    var aliasCharacterText: String?
    var imageCharacterImage: String?
    var descriptionCharacterText: String?
    var roleCharacterText: String?
    var aliveCharacterText: Bool?
    
    private func initializeCustomCell(){
        tableDetails.register(UINib(nibName: "ImageTableViewCell", bundle: .main), forCellReuseIdentifier: "imageTableViewCell")
        
        tableDetails.register(UINib(nibName: "TextTableViewCell", bundle: .main), forCellReuseIdentifier: "textTableViewCell")
    }
    
    private func cellIdentifier(for indexPath: IndexPath) -> String {
        if indexPath.row == 0 {
            return "imageTableViewCell"
        } else if indexPath.row == 1 {
            return "textTableViewCell"
        } else {
            return "textTableViewCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableDetails.dataSource = self

        initializeCustomCell()
        tableDetails.separatorStyle = .none // Remove separator line

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

extension DetailsEnemyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roleCharacterText == nil ? 3 : 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 316 : UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cellIdentifier(for: indexPath)
        
        if indexPath.row == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ImageTableViewCell
            imageCell.imageCustom?.sd_setImage(with: URL(string: imageCharacterImage ?? ""),
                                               placeholderImage: UIImage(named: "batman-logo"))
            imageCell.selectionStyle = .none
            return imageCell
        } else if indexPath.row == 1 {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            nameCell.textCustom?.text = nameCharacterText
            nameCell.textCustom.textAlignment = .center // Center the text
            nameCell.textCustom.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Change the font size of the text
            nameCell.selectionStyle = .none
            return nameCell
        } else {
            var textToDisplay: String?
            
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            descriptionCell.textCustom?.text = nil
            
            if (aliasCharacterText != nil && indexPath.row == 2) {
                textToDisplay = "Real Name: " + (aliasCharacterText ?? "") 
                descriptionCell.textCustom.textAlignment = .center // Center the text
            } else if (roleCharacterText != nil && indexPath.row == 3) {
                textToDisplay = "Role: " + (roleCharacterText ?? "")
            } else if (aliveCharacterText != nil && indexPath.row == 4) {
                textToDisplay = aliveCharacterText ?? true ? "Status: Alive" : "Status: Dead"
            } else {
                textToDisplay = descriptionCharacterText
            }
            
            
            descriptionCell.textCustom?.text = textToDisplay
            descriptionCell.selectionStyle = .none
            return descriptionCell
        }
    }
}


