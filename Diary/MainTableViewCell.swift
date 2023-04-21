//
//  MainTableViewCell.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
//        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        let margin = layoutMarginsGuide
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func config(_ task: Task) {
        titleLabel.text = task.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: task.startTime)
        timeLabel.text = timeString
    }
}
