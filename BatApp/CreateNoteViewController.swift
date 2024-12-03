import UIKit

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    
    var titleTextField: NotEmptyTextField?
    var descriptionTextField: NotEmptyTextField?
    
    let noteDAO: NoteDAO = NoteCoreStoreDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField = NotEmptyTextField(textInput: titleInput)
        descriptionTextField = NotEmptyTextField(textInput: descriptionInput)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Settings of the navigation bar
        self.title = "Create Note"
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func displayAlert (_ title: String, _ description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        // Add a default OK action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveNote(_ sender: Any) {
        do {
            // Check the fields
            try titleTextField?.validate()
            try descriptionTextField?.validate()
            
            // Save the note into DDBB
            let title = titleInput.text!
            let content = descriptionInput.text!
            
            noteDAO.createNote(title: title, description: content) { result in
                switch result {
                case .success:
                    print("Note created successfully!")
                    DispatchQueue.main.async {
                        // GO back to previous screen
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print("Failed to create note: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        // Show an alert with the error
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Failed to save note: \(error.localizedDescription)",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
            
        } catch {
            displayAlert("Error when creating a note", "Any field can be empty.")
        }
    }
}
