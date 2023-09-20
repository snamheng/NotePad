import UIKit
import CoreData

class TextEditorViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userInputTextView: UITextView!
    var hasText = false
    
    var selectedNote: DataNotes?

    override func viewDidLoad() {
        super.viewDidLoad()
        userInputTextView.delegate = self
        userInputTextView.textColor = .black
        userInputTextView.font = UIFont.boldSystemFont(ofSize: 22)
        getNotes()
    }
    
    func getNotes() {
        guard let note = selectedNote, let title = note.title, let subtitle = note.subtitle else {
            return
        }

        let attributedString = NSMutableAttributedString(string: title + "\n" + subtitle)

        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 22), range: NSRange(location: 0, length: title.count))

        let subtitleRange = NSRange(location: title.count + 1, length: subtitle.count)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: subtitleRange)

        userInputTextView.attributedText = attributedString
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.typingAttributes[.font] = UIFont.systemFont(ofSize: 18)
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == userInputTextView {
            hasText = !textView.text.isEmpty
            print("====")
            print(textView.text!)
        }
    }
    
    func saveNote() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext, let text = userInputTextView.text, !text.isEmpty else {
            return
        }
        
        if let selectedNote = selectedNote {
            let lines = text.components(separatedBy: "\n")
            let title = lines.first ?? ""
            let subtitle = lines.dropFirst().joined(separator: "\n")
            
            print("First: \(title)")
            print("Second: \(subtitle)")
            
            selectedNote.title = title
            selectedNote.subtitle = subtitle
        } else {
            let lines = text.components(separatedBy: .newlines)
            let title = (lines.first?.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "Untitled Note"
            let subtitle = lines.dropFirst().joined(separator: "\n").isEmpty ? "Default Text" : lines.dropFirst().joined(separator: "\n")
            
            let newNote = DataNotes(context: context)
            newNote.title = title
            newNote.subtitle = subtitle
        }
        do {
            try context.save()
        } catch {
            print("Error saving note: \(error)")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if hasText {
            saveNote()
        }
    }
}
