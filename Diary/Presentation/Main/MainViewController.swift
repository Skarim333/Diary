//
//  MainViewController.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import UIKit
import RealmSwift
import FSCalendar
import SnapKit

@available(iOS 13.0, *)
class MainViewController: UIViewController {
    
    private var calendar: FSCalendar = {
        let calenadar = FSCalendar()
        calenadar.translatesAutoresizingMaskIntoConstraints = false
        return calenadar
    }()
    let showHideButton: UIButton = {
       let button = UIButton()
        button.setTitle(NSLocalizedString("Открыть календарь", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var calendarHeightConstraint: Constraint!
    let dateFormatter = DateFormatterHelper.mainDateFormatter
    var dateComponents = DateComponents()
    
    private var viewModel: MainViewModelProtocol

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewOnDay(date: Date())
    }
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle(NSLocalizedString("Свернуть календарь", comment: ""), for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle(NSLocalizedString("Открыть календарь", comment: ""), for: .normal)
        }
    }
    
    func viewOnDay(date: Date) {
        viewModel.getTasksForDays(date: date)
        self.tableView.reloadData()
    }


    
    func setupBarButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(showAddView))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func showAddView() {
        viewModel.pushAddView()
    }
    
    
    private func timeString(for hour: Int) -> String {
        dateComponents.hour = hour
        dateComponents.minute = 0
        let roundedDate = Calendar.current.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: 0, of: Date())!
        return dateFormatter.string(from: roundedDate)
    }
}

@available(iOS 13.0, *)
extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.update(offset: bounds.height)
        view.layoutIfNeeded()
        calendar.locale = Locale(identifier: "Ru_ru")
        calendar.appearance.headerDateFormat = "LLLL YYYY"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewOnDay(date: date)
    }
    
}
@available(iOS 13.0, *)

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

@available(iOS 13.0, *)
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let timeString = self.timeString(for: section)
        return timeString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushEditingView(viewModel.result[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            viewModel.removeTask( indexPath.section, indexPath.row)
            self.tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

@available(iOS 13.0, *)
extension MainViewController {
    
    func setConstraints() {
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.leading.trailing.equalToSuperview()
            calendarHeightConstraint = make.height.equalTo(300).constraint
        }
        
        view.addSubview(showHideButton)
        showHideButton.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(showHideButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}
