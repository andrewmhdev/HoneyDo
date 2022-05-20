//
//  HomeTableViewController.swift
//  HoneyDo
//
//  Created by Andrew H on 5/20/22.
//

import UIKit

class HomeTableViewController: UITableViewController {


    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddScreen()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoController.sharedInstance.toDoList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else {return UITableViewCell()}
        let todo = ToDoController.sharedInstance.toDoList[indexPath.row]
        cell.loadCell(with: todo, with: self)

        // Configure the cell...

        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = ToDoController.sharedInstance.toDoList[indexPath.row]
            ToDoController.sharedInstance.delete(toDo)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
extension HomeTableViewController {
    func presentAddScreen() {
        let alertController = UIAlertController(title: "Create Todo item",message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "To do name..."
        }
        let createAction = UIAlertAction(title: "Create", style: .default) { [unowned alertController] _ in
            guard let newName = alertController.textFields?[0].text,
                  !newName.isEmpty
            else {return}
            ToDoController.sharedInstance.create(name: newName)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        alertController.addAction(createAction)
        
        present(alertController, animated: true)
    }
    
}
extension HomeTableViewController: ToDoTableViewCelllDelegate {
    func didToggleIscComplete(_ todo: ToDo) {
        ToDoController.sharedInstance.update(todo)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}



