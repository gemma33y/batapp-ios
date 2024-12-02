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
<<<<<<< HEAD
=======
                return note
>>>>>>> bb36bb4d707f758eb3d9cc37c800ae611429ecb2
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
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
<<<<<<< HEAD
            asynchronous: { (transaction) -> Void in
                let editableNote = transaction.edit(note)
                editableNote?.title = newTitle ?? editableNote?.title
                editableNote?.content = newDescription ?? editableNote?.description
=======
            asynchronous: { (transaction) -> Note in
                guard let editableNote = transaction.edit(note) else {
                    throw NoteDAO.NoteError.notEditable
                }
                editableNote.title = newTitle ?? editableNote?.title
                editableNote.content = newDescription ?? editableNote?.content
                return editableNote
>>>>>>> bb36bb4d707f758eb3d9cc37c800ae611429ecb2
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
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
                self.handleCompletion(result, completion: completion)
            }
        )
    }

<<<<<<< HEAD
    func handleCompletion(_ result: AsynchronousDataTransaction.Result<Any>, completion: @escaping (Result<Void, Error>) -> Void) {
=======
    func handleCompletion<T>(_ result: AsynchronousDataTransaction.Result<T>, completion: @escaping (Result<T, Error>) -> Void) {
>>>>>>> bb36bb4d707f758eb3d9cc37c800ae611429ecb2
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
