//
//  MasterViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//
import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["2018-10-26 11:44:53 +0000", "2024-12-01 10:00:00 +0000"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Hide the back button
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }

    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // UITableViewDelegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let splitVC = self.splitViewController,
           let detailVC = (splitVC.viewControllers.last as? UINavigationController)?.topViewController as? NoteDetailViewController {
            detailVC.updateContent(title: items[indexPath.row], description: "hola")
        }
    }
}
