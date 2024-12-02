//
//  MasterViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//
import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items: [Note] = []
        

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func initializeCustomCell(){
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: .main), forCellReuseIdentifier: "noteTableViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.dataSource = self

        initializeCustomCell()
        tableView.separatorStyle = .none // Remove separator line

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromNoteToDetails" {

            if let destination = segue.destination as? NoteDetailViewController,
               let note = sender as? Note {  // Get the index of the enemy clicked
                
                destination.descriptionText = note.description
                destination.titleText = note.title
            }
        }
    }
}



extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "noteTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NoteTableViewCell
        
        // Date
        let date = items[indexPath.row].time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = dateFormatter.string(from: date ?? Date())
        cell.timeLabel.text = formattedDate

        cell.timeLabel.textColor = .lightGray
        
        // Title
        cell.titleLabel.text = items[indexPath.row].title
        
        return cell
    }
}


extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a segue to show the description of the enemy -> fromEnemiesToDetail
        performSegue(withIdentifier: "fromNoteToDetails", sender: items[indexPath.row])
        
    }
}
