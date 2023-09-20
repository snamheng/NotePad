//
//  NotesViewController.swift
//  EditSpace
//
//  Created by heng on 14/9/23.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var noteTotal: UILabel!
    
    var notes: [DataNotes] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTable.dataSource = self
        noteTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    func updateNoteCount(){
        noteTotal?.text = "\(notes.count) Notes"
    }
    
    func fetchNotes() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DataNotes> = DataNotes.fetchRequest()
        
        do {
            notes = try context.fetch(fetchRequest)
            noteTable.reloadData()
            updateNoteCount()
        } catch {
            print("Error fetching notes: \(error.localizedDescription)")
        }
    }
    
    func deleteNote(note: DataNotes) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(note)
        
        do {
            try context.save()
        } catch {
            print("Error deleting note: \(error.localizedDescription)")
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTable.dequeueReusableCell(withIdentifier: "noteItems", for: indexPath) as! NoteItemTableViewCell
        
        let note = notes[indexPath.row]
        cell.noteItemTitle?.text = note.title
        cell.noteItemSubTitle?.text = note.subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "noteText", sender: selectedNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteText", let selectedNote = sender as? DataNotes {
            if let textEditorVC = segue.destination as? TextEditorViewController {
                textEditorVC.selectedNote = selectedNote
            }
        }
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let noteToDelete = self.notes[indexPath.row]
            self.deleteNote(note: noteToDelete)
            self.notes.remove(at: indexPath.row)
            self.updateNoteCount()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }
}
