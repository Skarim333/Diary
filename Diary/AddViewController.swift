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
        txt.placeholder = "Title"
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 5
        txt.accessibilityIdentifier = "inputName"
        txt.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        return txt
    }()
    
//    var descriptionTextField: PlaceholderTextView = {
//        let txt = PlaceholderTextView()
//        txt.layer.borderColor = UIColor.gray.cgColor
//        txt.layer.borderWidth = 1
//        txt.layer.cornerRadius = 5
//        txt.accessibilityIdentifier = "inputDescription"
//        txt.placeholderText = "Enter Description"
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        txt.font = UIFont.systemFont(ofSize: 17)
//        txt.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        return txt
//    }()
    var descriptionTextField: PlaceholderTextView = {
        let txt = PlaceholderTextView()
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 5
        txt.accessibilityIdentifier = "inputDescription"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        txt.placeholderText = "Enter Description"
        return txt
    }()
    
    var startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        return dp
    }()
    
//    let taskManager = TaskManager()
//    var task: Task?
    var viewModel = AddViewModel()
    //MARK: - INITIALIZATION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        configTap()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        configureFields()
    }
    
    @objc func addTask() {
        //        guard let name = nameTextField.text, !name.isEmpty,
        //              let description = descriptionTextField.text, !description.isEmpty else {
        //            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
        //            alert.addAction(UIAlertAction(title: "OK", style: .default))
        //            present(alert, animated: true)
        //            return
        //        }
        //        let newTask = Task()
        //        newTask.name = name
        //        newTask.taskDescription = description
        //        print(startDatePicker.date)
        //        newTask.startDate = startDatePicker.date
        //        let calendar = Calendar.current
        //        let component = calendar.dateComponents([.weekday], from: startDatePicker.date)
        //        guard let weekday = component.weekday else { return }
        //        newTask.repetitionsPerDay = weekday
        //        print(newTask.startDate)
        //        // Save the new task to Realm
        //        if task != nil {
        //            do {
        //                try taskManager.editTask(task!, withName: name, taskDescription: description, startTime: startDatePicker.date, startDate: Date(), repetitionsPerDay: weekday)
        //            } catch {
        //                print(error)
        //            }
        //        } else {
        //            do {
        //                try taskManager.addTask(newTask)
        //            } catch {
        //                print("Error saving task: \(error)")
        //            }
        //        }
        guard let name = nameTextField.text, !name.isEmpty,
        let description = descriptionTextField.text, !description.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let startTime = startDatePicker.date
        let calendar = Calendar.current
        let component = calendar.dateComponents([.weekday], from: startTime)
        guard let repetitionsPerDay = component.weekday else { return }
        do {
            try viewModel.addTask(name: name, description: description, startTime: startTime, repetitionsPerDay: repetitionsPerDay)
        } catch {
            print("Error saving task: (error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
        nameTextField.text = viewModel.task?.name
        descriptionTextField.text = viewModel.task?.taskDescription
        startDatePicker.date = viewModel.task?.startTime ?? Date()
    }
    func configTap() {
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
    }
    @objc private func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configureFields() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        nameTextField.inputAccessoryView = toolBar
        descriptionTextField.inputAccessoryView = toolBar
    }
    
    @objc func didTapKeyboardDone() {
        nameTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
    }
    
    //MARK: - SETUP & CONSTRAINTS
    
    func setUp() {
        view.addSubview(taskNameLabel)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(startLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(startDatePicker)
        
        let margin = view.layoutMarginsGuide
        
        let constraints: [NSLayoutConstraint] = [
            taskNameLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
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

