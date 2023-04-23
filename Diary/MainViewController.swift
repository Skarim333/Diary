//
//  MainViewController.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit
import RealmSwift
import FSCalendar

class MainViewController: UIViewController {
    // Создаем экземпляр TaskManager
    var calendarHeightConstraint: NSLayoutConstraint!
    let taskManager = TaskManager()
//    private var tasks = [Task]()
//    let model = Task()
    var viewModel = MainViewModel()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "H:mm"
        return formatter
    }()
    var dateComponents = DateComponents()
    private var calendar: FSCalendar = {
        let calenadar = FSCalendar()
        calenadar.translatesAutoresizingMaskIntoConstraints = false
        return calenadar
    }()
    let showHideButton: UIButton = {
       let button = UIButton()
        button.setTitle("Открыть календарь", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        calendar.delegate = self
        calendar.dataSource =  self
        calendar.scope = .week
        tableView.delegate = self
        tableView.dataSource = self
        setConstraints()
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        setupBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
//            try taskManager.removeAllTasks()
        } catch {
            print(error.localizedDescription)
        }
        print("Here")
        viewOnDay(date: Date())
    }
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Свернуть календарь", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Открыть календарь", for: .normal)
        }
    }
    
    func viewOnDay(date: Date) {
//        viewModel.getTasksForDay(date: date)
        viewModel.getTasksForDays(date: date)
        self.tableView.reloadData()
    }


    
    func setupBarButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(showAddView))
        button.accessibilityIdentifier =  "addButton"
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func showAddView() {
        viewModel.pushAddView()
    }
    
    
    private func timeString(for hour: Int) -> String {
//        print("hour - \(hour)")
        dateComponents.hour = hour
        dateComponents.minute = 0
        let roundedDate = Calendar.current.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: 0, of: Date())!
        return dateFormatter.string(from: roundedDate)
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
        calendar.locale = Locale(identifier: "Ru_ru")
        calendar.appearance.headerDateFormat = "LLLL YYYY"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewOnDay(date: date)
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.result.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.result[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.config(viewModel.result[indexPath.section][indexPath.row])

        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let timeString = self.timeString(for: section)
        return timeString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = AddViewController()
////        vc.viewModel.task = viewModel.tasks[indexPath.row]
//        vc.viewModel.task = viewModel.result[indexPath.section][indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
        viewModel.pushEditingView(viewModel.result[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
//            do {
//                try taskManager.removeTask(tasks[indexPath.row])
//            } catch {
//                print(error)
//            }
//            tasks = Array(taskManager.allTasks)
            viewModel.removeTask( indexPath.section, indexPath.row)
            self.tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

extension MainViewController {
    
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
