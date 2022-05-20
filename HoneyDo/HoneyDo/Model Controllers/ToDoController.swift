//
//  ToDoController.swift
//  HoneyDo
//
//  Created by Andrew H on 5/20/22.
//

import Foundation


class ToDoController {
    
    static let sharedInstance = ToDoController()
    
    var toDoList = [ToDo]()
    
    init() {
        readFromDisk()
    }
    
    //MARK: CRUD
    func create(name: String, isComplete: Bool = false) {
        let newToDo = ToDo(name: name, isComplete: isComplete)
        toDoList.append(newToDo)
        saveToDisk()
    }
    
    func delete(_ toDo: ToDo) {
        guard let index = toDoList.firstIndex(of: toDo) else {return}
        toDoList.remove(at: index)
        saveToDisk()
    }
    func update(_ todo: ToDo) {
        todo.isComplete.toggle()
        saveToDisk()
    }
    
}

extension ToDoController {
    private var fileURL: URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                else {return nil}
        let url = documentDirectory.appendingPathComponent("honeydo.json")
        return url
    }
    private func saveToDisk() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(self.toDoList)
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    private func readFromDisk() {
        guard let url = fileURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let toDoList = try JSONDecoder().decode([ToDo].self, from: data)
            self.toDoList = toDoList
            
        } catch let error {
            print(error)
        }
    }
}
