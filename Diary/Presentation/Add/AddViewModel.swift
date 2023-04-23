//
//  AddViewModel.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import Foundation

@available(iOS 13.0, *)

protocol AddViewModelProtocol {
    var task: Task? { get }
    func addTask(name: String, description: String, startTime: Date, repetitionsPerDay: Int) throws
    func didFinish()
}

protocol AddViewModelOutput: AnyObject {
    func didFinishAddScene()
}

class AddViewModel: AddViewModelProtocol {
    weak var output: AddViewModelOutput?
    private let taskManager: TaskManager
    var task: Task?

    init(taskManager: TaskManager, task: Task? = nil, output: AddViewModelOutput?) {
        self.taskManager = taskManager
        self.output = output
        self.task = task
    }

    func addTask(name: String, description: String, startTime: Date, repetitionsPerDay: Int) throws {
        let newTask = Task()
        newTask.name = name
        newTask.taskDescription = description
        newTask.startTime = startTime
        newTask.repetitionsPerDay = repetitionsPerDay
        if task != nil {
            try taskManager.editTask(task!, withName: name, taskDescription: description, startTime: startTime, startDate: Date(), repetitionsPerDay: repetitionsPerDay)
        } else {
            try taskManager.addTask(newTask)
        }
        output?.didFinishAddScene()
    }
    
    func didFinish() {
        output?.didFinishAddScene()
    }

}
