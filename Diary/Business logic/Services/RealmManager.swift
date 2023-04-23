//
//  RealmManager.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import RealmSwift

class TaskManager {
    
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }
    // добавление новой задачи
    func addTask(_ task: Task) throws {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            throw error
        }
    }
    
    // удаление задачи
    func removeTask(_ task: Task) throws {
        do {
            try realm.write {
                realm.delete(task)
            }
        } catch {
            throw error
        }
    }
    
    // изменение задачи
    func editTask(_ task: Task, withName name: String?, taskDescription: String?,startTime: Date?, startDate: Date?, repetitionsPerDay: Int?) throws {
        do {
            try realm.write {
                if let name = name {
                    task.name = name
                }
                if let taskDescription = taskDescription {
                    task.taskDescription = taskDescription
                }
                if let startTime = startTime {
                    task.startTime = startTime
                }
                if let startDate = startDate {
                    task.startDate = startDate
                }
                if let repetitionsPerDay = repetitionsPerDay {
                    task.repetitionsPerDay = repetitionsPerDay
                }
            }
        } catch {
            throw error
        }
    }
    
    // получение всех задач
    var allTasks: Results<Task> {
        print(realm.objects(Task.self))
        return realm.objects(Task.self)
    }
    
    func removeAllTasks() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw error
        }
    }

}
