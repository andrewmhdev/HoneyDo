//
//  ToDoTableViewCell.swift
//  HoneyDo
//
//  Created by Andrew H on 5/20/22.
//

import UIKit

protocol ToDoTableViewCelllDelegate: AnyObject {
    func didToggleIscComplete(_ todo: ToDo)
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    var toDo: ToDo? = nil
    
    weak var delegate: ToDoTableViewCelllDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(with todo: ToDo, with delegate: ToDoTableViewCelllDelegate) {
        self.delegate = delegate
        self.toDo = todo
        self.nameLabel.text = todo.name
        let buttonImage = todo.isComplete ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        self.isCompleteButton.setImage(buttonImage, for: .normal)
    }

    @IBAction func didTapIsComplete(_ sender: Any) {
        guard let toDo = toDo else {return}
        delegate?.didToggleIscComplete(toDo)
    }
}
