//
//  DetailsEnemyViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 27/10/24.
//

import UIKit

class DetailsEnemyViewController: UIViewController {


    @IBOutlet weak var tableDetails: UITableView!
    
    
    // Properties to receive data
    var nameEnemyText: String?
    var imageEnemyImage: UIImage?
    var descriptionEnemyText: String?
    
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
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 316 : UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cellIdentifier(for: indexPath)
        
        if indexPath.row == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ImageTableViewCell
            imageCell.imageCustom?.image = imageEnemyImage
            imageCell.selectionStyle = .none
            return imageCell
        } else if indexPath.row == 1 {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            nameCell.textCustom?.text = nameEnemyText
            nameCell.textCustom.textAlignment = .center // Center the text
            nameCell.textCustom.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Change the font size of the text
            nameCell.selectionStyle = .none
            return nameCell
        } else {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            descriptionCell.textCustom?.text = nil
            descriptionCell.textCustom?.text = descriptionEnemyText
            descriptionCell.selectionStyle = .none
            return descriptionCell
        }
    }
}


