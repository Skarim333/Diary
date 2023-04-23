//
//  MainTableViewCell.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
        
        timeLabel.snp.makeConstraints { make in
                make.bottom.equalTo(margin)
                make.leading.equalTo(margin)
                make.width.equalTo(40)
                make.top.equalTo(margin)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.bottom.equalTo(margin)
                make.leading.equalTo(timeLabel.snp.trailing).offset(5)
                make.trailing.equalTo(margin)
                make.top.equalTo(margin)
            }
    }
    
    func config(_ task: Task) {
        let formatter = DateFormatterHelper.shortDateFormatter
        timeLabel.text = formatter.string(from: task.startTime)
        titleLabel.text = task.name
    }
}
