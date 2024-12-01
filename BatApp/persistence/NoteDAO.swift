// Interface that defines all the methods available for the Note class (implemented then by different specific DAOs).
enum NoteError: LocalizedError {
    case notEditable
    case notFound

    var errorDescription: String? {
        switch self {
            case .notEditable:
                return "Failed to find editable note."
            case .notFound:
                return "The requested note was not found."
        }
    }
}

protocol NoteDAO {
    // Create
    func createNote(title: String, description: String, completion: @escaping (Result<Note, Error>) -> Void)
    
    // Read
    func fetchAllNotes() -> [Note]
    
    // Update
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Note, Error>) -> Void)
    
    // Delete
    func deleteNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void)
}