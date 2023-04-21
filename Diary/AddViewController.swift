//
//  AddViewControllerA.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

class AddViewController: UIViewController {
    
    var taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        return label
    }()
    
    var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var startLabel: UILabel = {
        let label = UILabel()
        label.text = "Start date:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = " Task name"
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1.0
        txt.layer.cornerRadius = 5.0
        txt.accessibilityIdentifier = "inputName"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var descriptionTextField: UITextView = {
        let txt = UITextView()
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1.0
        txt.layer.cornerRadius = 5.0
        txt.sizeToFit()
        txt.accessibilityIdentifier = "inputDescription"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.translatesAutoresizingMaskIntoConstraints = false
//        dp.preferredDatePickerStyle = .wheels
        dp.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        return dp
    }()
    
    let taskManager = TaskManager()
    var task: Task?
    //MARK: - INITIALIZATION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        print(startDatePicker.date)
    }
    @objc func addTask() {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let newTask = Task()
        newTask.name = name
        newTask.taskDescription = description
        print(startDatePicker.date)
        newTask.startDate = startDatePicker.date
        let calendar = Calendar.current
        let component = calendar.dateComponents([.weekday], from: startDatePicker.date)
        guard let weekday = component.weekday else { return }
        newTask.repetitionsPerDay = weekday
        print(newTask.startDate)
        // Save the new task to Realm
        if task != nil {
            do {
                try taskManager.editTask(task!, withName: name, taskDescription: description, startTime: startDatePicker.date, startDate: Date(), repetitionsPerDay: weekday)
            } catch {
                print(error)
            }
        } else {
            do {
                try taskManager.addTask(newTask)
            } catch {
                print("Error saving task: \(error)")
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = task?.name
        descriptionTextField.text = task?.taskDescription
        startDatePicker.date = task?.startTime ?? Date()
    }
    
    @objc private func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - SETUP & CONSTRAINTS
    
    func setUp() {
        view.addSubview(taskNameLabel)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(startLabel)
        //        view.addSubview(finishLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        //        view.addSubview(addTaskButton)
        view.addSubview(startDatePicker)
        //        view.addSubview(finishDatePicker)
        
        let margin = view.layoutMarginsGuide
        
        let constraints: [NSLayoutConstraint] = [
            taskNameLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            nameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            taskDescriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            descriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            descriptionTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            descriptionTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.2),
            descriptionTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            
            startLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
            startLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            startDatePicker.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10),
            startDatePicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            startDatePicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

