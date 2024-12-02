import CoreStore

// Class that implements the NoteDAO operations using CoreStore Wrapper to interact with Swift DDBB.
class NoteCoreStoreDAO: NoteDAO {

    // Create
    func createNote(title: String, description: String, completion: @escaping (Result<Void, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                let note = transaction.create(Into<Note>())
                note.title = title
                note.content = description
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Read
    func fetchAllNotes() -> [Note] {
        do {
            return try CoreStoreDefaults.dataStack.fetchAll(From<Note>())
        } catch {
            print("Error fetching notes: \(error)")
            return []
        }
    }
    
    // Update
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                let editableNote = transaction.edit(note)
                editableNote?.title = newTitle ?? editableNote?.title
                editableNote?.content = newDescription ?? editableNote?.description
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
                transaction.delete(note)
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
            }
        )
    }

    func handleCompletion(_ result: AsynchronousDataTransaction.Result<Any>, completion: @escaping (Result<Void, Error>) -> Void) {
        switch result {
            // The transaction succeeded.
            case .success:
                completion(.success(()))

            // The transaction failed.
            case .failure(let error):
                completion(.failure(error))
        }
    }
}
