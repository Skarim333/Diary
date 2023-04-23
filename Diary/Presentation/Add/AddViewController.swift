//
//  AddViewControllerA.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

@available(iOS 13.0, *)
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
    
    private var viewModel: AddViewModelProtocol

    init(viewModel: AddViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - INITIALIZATION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        configTap()
        setupBarButton()
        configureFields()
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
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTask))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pushBack))
    }
    
    @objc func addTask() {
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
    
    @objc func pushBack() {
        viewModel.didFinish()
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

        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(margin.snp.top)
            make.leading.equalTo(margin.snp.leading)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(taskNameLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.equalTo(margin.snp.leading)
            make.trailing.equalTo(margin.snp.trailing)
        }

        taskDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalTo(margin.snp.leading)
        }

        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(margin.snp.leading)
            make.height.equalTo(margin.snp.height).multipliedBy(0.2)
            make.trailing.equalTo(margin.snp.trailing)
        }

        startLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(10)
            make.leading.equalTo(margin.snp.leading)
        }

        startDatePicker.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(10)
            make.height.equalTo(margin.snp.height).multipliedBy(0.1)
            make.leading.equalTo(margin.snp.leading)
        }

    }
}

