//
//  TimeCell.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit

class TimeCell: UITableViewCell {
    
    static let identifier = "TimeCell"
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать время"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

