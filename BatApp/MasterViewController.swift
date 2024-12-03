//
//  MasterViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/12/24.
//
import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fakeNotes: [FakeNote] = []
    var notes: [Note] = []
        
    let noteDAO = NoteCoreStoreDAO()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func initializeCustomCell(){
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: .main), forCellReuseIdentifier: "noteTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        
        initializeCustomCell()
        tableView.separatorStyle = .none // Remove separator line
        
       
        noteDAO.fetchAllNotes { result in
            switch result {
                case .success(let fetchedNotes):
                    // Clear the current notes array
                    self.notes = fetchedNotes
                    self.fakeNotes.removeAll()

                   // Add each note one by one
                   for note in fetchedNotes {
                       let test = FakeNote(title: note.title!, content: note.content!, date: note.date!)
                       self.fakeNotes.append(test)
                   }
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error al recuperar las notas: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromNoteToDetails" {

            if let destination = segue.destination as? NoteDetailViewController,
               let note = sender as? FakeNote {  // Get the index of the enemy clicked
                
                destination.descriptionText = note.content
                destination.titleText = note.title
            }
        }
    }
}



extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "noteTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NoteTableViewCell

       
        let note = self.fakeNotes[indexPath.row]
        // Debug: Imprimir el estado del objeto
        print("Accediendo a la celda:")
        print("Título: \(note.title)")
        print("Contenido: \(note.content)")
        print("Time: \(note.date)")
        
        // Configure the cell
        cell.titleLabel.text = note.title
        cell.titleLabel.textColor = .black

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.timeLabel.text = dateFormatter.string(from: note.date)
        cell.timeLabel.textColor = .lightGray

        return cell
    }
    
    // Enable swipe-to-delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = self.notes[indexPath.row]
            
            // Show confirmation alert
            let alertController = UIAlertController(
                title: "Delete Note",
                message: "Are you sure you want to delete this note?",
                preferredStyle: .alert
            )
            
            // Confirm action
            let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                // Use the DAO to delete the note
                self.noteDAO.deleteNote(note: noteToDelete) { result in
                    switch result {
                    case .success:
                        // Remove the note from the local array and update the UI
                        DispatchQueue.main.async {
                            self.notes.remove(at: indexPath.row)
                            self.fakeNotes.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    case .failure(let error):
                        // Show an error alert
                        DispatchQueue.main.async {
                            let errorAlert = UIAlertController(
                                title: "Error",
                                message: "Failed to delete the note: \(error.localizedDescription)",
                                preferredStyle: .alert
                            )
                            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(errorAlert, animated: true)
                        }
                    }
                }
            }
            
            // Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            // Add actions to the alert
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            // Present the confirmation alert
            self.present(alertController, animated: true, completion: nil)
        }
    }


}


extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create a segue to show the description of the enemy -> fromEnemiesToDetail
        performSegue(withIdentifier: "fromNoteToDetails", sender: fakeNotes[indexPath.row])
    }
}
