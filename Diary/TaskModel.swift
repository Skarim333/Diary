//
//  TaskModel.swift
//  Diary
//
//  Created by Карим Садыков on 19.04.2023.
//

import RealmSwift

class Task: Object {
    
    @Persisted var id =  UUID().uuidString
    @Persisted var startDate = Date()
    @Persisted var name: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var repetitionsPerDay: Int = 1
    
    override static func primaryKey() -> String? {
           return "id"
       }
}
