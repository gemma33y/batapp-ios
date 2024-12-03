import CoreStore
import Foundation

// Class that implements the NoteDAO operations using CoreStore Wrapper to interact with Swift DDBB.
class NoteCoreStoreDAO: NoteDAO {

    // Create a new Note
    func createNote(title: String, description: String, completion: @escaping (Result<Note, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { transaction -> Note in
                let note = transaction.create(Into<Note>())
                note.title = title
                note.content = description
                note.date = Date()
                return note
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Read all the Notes
    func fetchAllNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { transaction -> [Note] in
                return try transaction.fetchAll(From<Note>())
            },
            completion: { result in
                self.handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Update an existing Note
    func updateNote(note: Note, newTitle: String?, newDescription: String?, completion: @escaping (Result<Note, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Note in
                guard let editableNote = transaction.edit(note) else {
                    throw NoteError.notEditable
                }
                editableNote.title = newTitle ?? editableNote.title
                editableNote.content = newDescription ?? editableNote.content
                return editableNote
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
            }
        )
    }
    
    // Delete a Note
    func deleteNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                guard let editableNote = transaction.edit(note) else {
                    throw NoteError.notFound
                }
                transaction.delete(editableNote)
            },
            completion: { (result) -> Void in
                self.handleCompletion(result, completion: completion)
            }
        )
    }

    // Generic completion handler for CoreStore transactions
    func handleCompletion<T>(_ result: AsynchronousDataTransaction.Result<T>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
