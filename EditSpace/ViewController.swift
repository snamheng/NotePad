//
//  ViewController.swift
//  EditSpace
//
//  Created by heng on 12/9/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<DataNotes> = DataNotes.fetchRequest()
    
    let folders = [
            [folder(folderIcon: "calendar", folderTitle: "Quick Notes")],
            [folder(folderIcon: "folder", folderTitle: "Notes")]]

    @IBOutlet weak var tableCategory: UITableView!
    
    let tableCategoryIdentifier = "FolderTableViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableCategory.separatorStyle = .none
        tableCategory.dataSource = self
        tableCategory.delegate = self
        tableCategory.register(UINib.init(nibName: tableCategoryIdentifier, bundle: .none), forCellReuseIdentifier: tableCategoryIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableCategory.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return nil
        }

        return "ICLOUD"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableCategory.dequeueReusableCell(withIdentifier: tableCategoryIdentifier, for: indexPath) as! FolderTableViewCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        let folderItem = folders[indexPath.section][indexPath.row]
                
        cell.folderIcon.image = UIImage(systemName: folderItem.folderIcon)
        cell.folderTitle.text = folderItem.folderTitle
        cell.folderAmount.text = "0"

        do {
            if indexPath.section == 1 && indexPath.row == 0 {
            let count = try context.count(for: fetchRequest)
                cell.folderAmount.text = "\(count)"
            }
        } catch {
            cell.folderAmount.text = "0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)

            performSegue(withIdentifier: "notesSegue", sender: cell)
        }
    }
}

