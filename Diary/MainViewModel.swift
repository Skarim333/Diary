//
//  MainViewModel.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import Foundation

class MainViewModel {
    
    private let taskManager = TaskManager()
    var coordinator: MainCoordinator?
//    var tasks: [Task] = []
    var result: [[Task]] = [[]]
    
    init() {
        
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
    
//    func getTasksForDay(date: Date) {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.weekday], from: date)
//        guard let weekday = components.weekday else { return }
//        
//        let dateStart = calendar.startOfDay(for: date)
//        let dateEnd = calendar.date(byAdding: .day, value: 1, to: dateStart)!
//        
//        let predicate = NSPredicate(format: "repetitionsPerDay == %d AND startDate >= %@ AND startDate < %@", weekday, dateStart as NSDate, dateEnd as NSDate)
//        tasks = Array(taskManager.allTasks.filter(predicate).sorted(byKeyPath: "startTime"))
//    }
    
    func getTasksForDays(date: Date) -> [[Task]] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return [] }
        
        let dateStart = calendar.startOfDay(for: date)
        let dateEnd = calendar.date(byAdding: .day, value: 1, to: dateStart)!
        
        let predicate = NSPredicate(format: "repetitionsPerDay == %d AND startDate >= %@ AND startDate < %@", weekday, dateStart as NSDate, dateEnd as NSDate)
        let sortedTasks = taskManager.allTasks.filter(predicate).sorted(byKeyPath: "startTime")
        
        result = Array(repeating: [], count: 24)
        for task in sortedTasks {
            let hour = calendar.component(.hour, from: task.startTime)
            result[hour].append(task)
        }
        return result
    }

    
    func pushAddView() {
        self.coordinator?.startAddScene()
    }
    
    func pushEditingView(_ task: Task) {
        self.coordinator?.startEditingScene(task)
    }
}
