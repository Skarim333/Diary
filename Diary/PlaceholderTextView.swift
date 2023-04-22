//
//  PlaceholderTextView.swift
//  Diary
//
//  Created by Карим Садыков on 22.04.2023.
//

import UIKit

class PlaceholderTextView: UITextView {

    var placeholderText: String? {
        didSet {
            if let text = placeholderText {
                placeholderLabel.text = text
            }
        }
    }

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = self.font
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePlaceholder()
    }

    override var text: String! {
        didSet {
            updatePlaceholder()
        }
    }

    private func setupPlaceholder() {
        addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }

    private func updatePlaceholder() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
