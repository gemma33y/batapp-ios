// Interface that defines all the methods available for the Note class (implemented then by different specific DAOs).
protocol NoteDAO {
    // Create
    func createNote(title: String, description: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    // Read
    func fetchAllNotes() -> [Note]
    
    // Update
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Void, Error>) -> Void)
    
    // Delete
    func deleteNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void)
}
