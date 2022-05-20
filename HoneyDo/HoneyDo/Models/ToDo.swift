//
//  ToDo.swift
//  HoneyDo
//
//  Created by Andrew H on 5/20/22.
//

import Foundation


class ToDo: Codable {
    let uuid: String
    let name: String
    var isComplete: Bool
    
    init(uuid: String = UUID().uuidString,name: String, isComplete: Bool = false) {
        self.uuid = uuid
        self.name = name
        self.isComplete = isComplete
    }
    
}

extension ToDo: Equatable {
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        lhs.name == rhs.name &&
        lhs.isComplete == rhs.isComplete &&
        lhs.uuid == rhs.uuid
    }
}
