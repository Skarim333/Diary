////
////  AddViewController.swift
////  Diary
////
////  Created by Карим Садыков on 19.04.2023.
////
//
//import UIKit
//
//class AddViewController: UIViewController {
//    
//    enum SectionV: Int, CaseIterable {
//        case titleNotes
//        case time
//        case date
//        
//        var title: String {
//            switch self {
//            case .titleNotes:
//                return "Title and Notes"
//            case .time:
//                return "Time"
//            case .date:
//                return "Date"
//            }
//        }
//    }
//    let taskManager = TaskManager()
//    var tasks = Task()
//    let labelChekDate: String = "1"
//    let labelChekTime: String = "2"
//    private let tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
//        tableView.register(NotesCell.self, forCellReuseIdentifier: NotesCell.identifier)
//        tableView.register(TimeCell.self, forCellReuseIdentifier: TimeCell.identifier)
//        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        setupTableView()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
//    }
//    
//    @objc func addNewTask() {
//        let titleIndexPath = IndexPath(row: 0, section: SectionV.titleNotes.rawValue)
//            let notesIndexPath = IndexPath(row: 1, section: SectionV.titleNotes.rawValue)
//            let timeIndexPath = IndexPath(row: 0, section: SectionV.time.rawValue)
//            let dateIndexPath = IndexPath(row: 0, section: SectionV.date.rawValue)
//            
//            // Get the cells at those index paths
//            let titleCell = tableView.cellForRow(at: titleIndexPath) as! TitleCell
//            let notesCell = tableView.cellForRow(at: notesIndexPath) as! NotesCell
//            let timeCell = tableView.cellForRow(at: timeIndexPath) as! TimeCell
//            let dateCell = tableView.cellForRow(at: dateIndexPath) as! DateCell
//            
//            // Extract the data from the cells
//        let title = titleCell.titleTextField.text ?? ""
//        let notes = notesCell.descriptionTextField.text ?? ""
////        let time = timeCell.timeLabel.text
////            let date = dateCell.datePicker.date
//            
//            // Create a new Task object with the extracted data
//            let newTask = Task()
//            newTask.name = title
//            newTask.taskDescription = notes
////            newTask.startDate = date
//            
//            // Save the new task to Realm
//            do {
//                try taskManager.addTask(newTask)
//            } catch {
//                print("Error saving task: \(error)")
//            }
//    }
//    
//    func setupTableView() {
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//}
//
//extension AddViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let section = SectionV(rawValue: section) else {
//            return 0
//        }
//        
//        switch section {
//        case .titleNotes:
//            return 2
//        case .time:
//            return 1
//        case .date:
//            return 1
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return SectionV.allCases.count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let section = SectionV(rawValue: section) else {
//            return nil
//        }
//        
//        return section.title
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = SectionV(rawValue: indexPath.section) else {
//            return 0
//        }
//        
//        switch section {
//        case .titleNotes:
//            return indexPath.row == 0 ? 44 : 180
//        default:
//            return 44
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let section = SectionV(rawValue: indexPath.section) else {
//            return UITableViewCell()
//        }
//        switch section {
//        case .titleNotes:
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
//                // configure TitleCell here
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.identifier, for: indexPath) as! NotesCell
//                // configure NotesCell here
//                return cell
//            }
//        case .time:
//            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.identifier, for: indexPath) as! TimeCell
//            // configure TitleCell here
//            return cell
//        case .date:
//            let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath) as! DateCell
//            // configure TitleCell here
//            return cell
//        }
//    }
//    
//}
//
//extension AddViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 1:
//            guard let cell = tableView.cellForRow(at: indexPath) as? TimeCell else {
//                        return // ячейка еще не создана
//                    }
//            alertTime(label: cell.timeLabel) {(time) in
//                self.tasks.startTime = time
//                cell.timeLabel.text = self.labelChekTime
//                if cell.timeLabel.text == "2" {
//                    cell.timeLabel.textColor = .black
//                }
//                
////                self.updateSabeButtonState()
//            }
//
//            case 2:
//            guard let cell = tableView.cellForRow(at: indexPath) as? DateCell else {
//                        return
//                    }
//                alertDate(label: cell.dateLabel) {(numberWeekday, date) in
//                    self.tasks.startDate = date
//                    self.tasks.repetitionsPerDay = numberWeekday
//                    cell.dateLabel.text = self.labelChekDate
//                    if cell.dateLabel.text == "1" {
//                        cell.dateLabel.textColor = .black
//                    }
//                    cell.dateLabel.text = "fafda"
//                    
////                    self.updateSabeButtonState()
//                }
//            
//        default:
//            print("Error")
//        }
//    }
//}
//
//extension AddViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let cell = textField.superview?.superview as? TitleCell {
//            
//        }
//        else if let cell = textField.superview?.superview as? NotesCell {
//            
//        }
//        
//        // получить данные из UITextField
//        let text = textField.text
//        
//        // Ваш код здесь
//    }
//}
//
//
