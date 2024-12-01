import CoreStore

// Class that implements the NoteDAO operations using CoreStore Wrapper to interact with Swift DDBB.
class NoteCoreStoreDAO: NoteDAO {

    // Create
    func createNote(title: String, description: String, completion: @escaping (Result<Note, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Note in
                let note = transaction.create(Into<Note>())
                note.title = title
                note.content = description
                return note
            },
            completion: { (result) -> Void in
                handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Read
    func fetchAllNotes() -> [Note] {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { transaction -> [Note] in
                return try transaction.fetchAll(From<Note>())
            },
            completion: { result in
                handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Update
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Note, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Note in
                guard let editableNote = transaction.edit(note) else {
                    throw NoteDAO.NoteError.notEditable
                }
                editableNote.title = newTitle ?? editableNote?.title
                editableNote.content = newDescription ?? editableNote?.content
                return editableNote
            },
            completion: { (result) -> Void in
                handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Delete
    func deleteNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                if let editableNote = transaction.edit(note) {
                    transaction.delete(editableNote)
                } else {
                    throw NoteDAO.NoteError.notFound
                }
            },
            completion: { (result) -> Void in
                handleCompletion(result, completion: completion)
            }
        )
    }

    func handleCompletion<T>(_ result: AsynchronousDataTransaction.Result<T>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
            // The transaction succeeded.
            case .success(let value):
                completion(.success(value))

            // The transaction failed.
            case .failure(let error):
                completion(.failure(error))
        }
    }
}