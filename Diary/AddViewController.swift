//
//  AddViewController.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit

class AddViewController: UIViewController {
    
    enum SectionV: Int, CaseIterable {
        case titleNotes
        case time
        case date
        
        var title: String {
            switch self {
            case .titleNotes:
                return "Title and Notes"
            case .time:
                return "Time"
            case .date:
                return "Date"
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(NotesCell.self, forCellReuseIdentifier: NotesCell.identifier)
        tableView.register(TimeCell.self, forCellReuseIdentifier: TimeCell.identifier)
        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
    }
    
    @objc func addNewTask() {
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionV(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .titleNotes:
            return 2
        case .time:
            return 1
        case .date:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionV.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SectionV(rawValue: section) else {
            return nil
        }
        
        return section.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SectionV(rawValue: indexPath.section) else {
            return 0
        }
        
        switch section {
        case .titleNotes:
            return indexPath.row == 0 ? 44 : 180
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionV(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .titleNotes:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
                // configure TitleCell here
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.identifier, for: indexPath) as! NotesCell
                // configure NotesCell here
                return cell
            }
        case .time:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.identifier, for: indexPath) as! TimeCell
            // configure TitleCell here
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath) as! DateCell
            // configure TitleCell here
            return cell
        }
    }
    
}

extension AddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.identifier, for: indexPath) as! TimeCell
//            alertTime(label: cell.timeLabel) {(time) in
//                self.viewModel.viewTime = time
//                self.labelTime.text = self.labelChekTime
//                if self.labelTime.text == "2" {
//                    self.labelTime.textColor = .black
//                }
//                self.updateSabeButtonState()
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath) as! DateCell
//                alertDate(label: cell.da?teLabel) {(numberWeekday, date) in
//                    self.viewModel.viewDate = date
//                    self.viewModel.viewWeekday = numberWeekday
//                    self.labelDate.text = self.labelChekDate
//                    if self.labelDate.text == "1" {
//                        self.labelDate.textColor = .black
//                    }
//                    self.updateSabeButtonState()
//                }
            
        default:
            print("Error")
        }
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cell = textField.superview?.superview as? TitleCell {
            
        }
        else if let cell = textField.superview?.superview as? NotesCell {
            
        }
        
        // получить данные из UITextField
        let text = textField.text
        
        // Ваш код здесь
    }
}


