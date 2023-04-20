//
//  NotesCell.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit

class NotesCell: UITableViewCell {
    
    static let identifier = "NotesCell"
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Notes"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(descriptionTextField)
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: topAnchor),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            descriptionTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
