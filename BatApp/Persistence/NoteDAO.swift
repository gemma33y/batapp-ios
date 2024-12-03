import CoreStore

// Error type for NoteDAO operations
enum NoteError: LocalizedError {
    case notEditable
    case notFound
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .notEditable:
            return "Failed to find an editable note."
        case .notFound:
            return "The requested note was not found."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

// Interface that defines all the methods available for the Note class (implemented then by different specific DAOs).
protocol NoteDAO {
    
    // Create a new Note
    func createNote(title: String, description: String, completion: @escaping (Result<Note, Error>) -> Void)
    
    // Read all Notes
    func fetchAllNotes(completion: @escaping (Result<[Note], Error>) -> Void)
    
    // Update an existing Note
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Note, Error>) -> Void)
    
    // Delete a Note
    func deleteNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void)
}
