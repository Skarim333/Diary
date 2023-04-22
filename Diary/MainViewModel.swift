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
    var tasks: [Task] = []
    
    init() {
        
    }
    
    func removeTask(at index: Int) {
        do {
            try taskManager.removeTask(tasks[index])
        } catch {
            print(error)
        }
        tasks = Array(taskManager.allTasks)
    }
    
    func getTasksForDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        
        let dateStart = calendar.startOfDay(for: date)
        let dateEnd = calendar.date(byAdding: .day, value: 1, to: dateStart)!
        
        let predicate = NSPredicate(format: "repetitionsPerDay == %d AND startDate >= %@ AND startDate < %@", weekday, dateStart as NSDate, dateEnd as NSDate)
        tasks = Array(taskManager.allTasks.filter(predicate).sorted(byKeyPath: "startTime"))
    }
    
    func pushAddView() {
        self.coordinator?.startAddScene()
    }
}
