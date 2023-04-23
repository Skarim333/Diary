//
//  MainViewModel.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var result: [[Task]] { get }
    func removeTask(_ section: Int, _ row: Int)
    func getTasksForDays(date: Date) -> [[Task]]
    func pushAddView()
    func pushEditingView(_ task: Task)
}

protocol MainViewModelOutput: AnyObject {
    func startAddScene()
    func startEditingScene(_ task: Task)
}

@available(iOS 13.0, *)
class MainViewModel: MainViewModelProtocol {
    
    weak var output: MainViewModelOutput?
    private let taskManager: TaskManager
    var result: [[Task]] = [[]]
    
    init(taskManager: TaskManager, output: MainViewModelOutput?) {
        self.taskManager = taskManager
        self.output = output
    }
    
    func removeTask(_ section: Int, _ row: Int) {
        do {
            try taskManager.removeTask(result[section][row])
        } catch {
            print(error)
        }
           // Перестроение массива result на основе обновленных данных
           result = getTasksForDays(date: Date())
    }
    
    func getTasksForDays(date: Date) -> [[Task]] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return [] }
        
        let dateStart = calendar.startOfDay(for: date)
        let dateEnd = calendar.date(byAdding: .day, value: 1, to: dateStart)!
        
        let predicate = NSPredicate(format: "repetitionsPerDay == %d AND startTime >= %@ AND startTime < %@", weekday, dateStart as NSDate, dateEnd as NSDate)
        let sortedTasks = taskManager.allTasks.filter(predicate).sorted(byKeyPath: "startTime")
        print(sortedTasks)
        result = Array(repeating: [], count: 24)
        for task in sortedTasks {
            let hour = calendar.component(.hour, from: task.startTime)
            result[hour].append(task)
        }
        return result
    }

    
    func pushAddView() {
        output?.startAddScene()
    }
    
    func pushEditingView(_ task: Task) {
        output?.startEditingScene(task)
    }
}
