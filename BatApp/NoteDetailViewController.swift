//
//  NoteDetailViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet weak var tableDetails: UITableView!
    
    // Properties to receive data
    var titleText: String?
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateContent(title: String, description: String) {
        titleText = title
        descriptionText = description
    }
    
    private func cellIdentifier(for indexPath: IndexPath) -> String {
        return "textTableViewCell"
    }
    
    private func initializeCustomCell(){        
        tableDetails.register(UINib(nibName: "TextTableViewCell", bundle: .main), forCellReuseIdentifier: "textTableViewCell")
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


extension NoteDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 316 : UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cellIdentifier(for: indexPath)
        
        if indexPath.row == 0 {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            nameCell.textCustom?.text = titleText
            nameCell.textCustom.textAlignment = .center // Center the text
            nameCell.textCustom.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Change the font size of the text
            nameCell.selectionStyle = .none
            return nameCell
        } else {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            descriptionCell.textCustom?.text = nil
            
            descriptionCell.textCustom?.text = descriptionText
            descriptionCell.selectionStyle = .none
            return descriptionCell
        }
    }
}


