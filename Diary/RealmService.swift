//
//  RealmService.swift
//  Diary
//
//  Created by Карим Садыков on 22.04.2023.
//

import RealmSwift

class RealmService {

    static let shared = RealmService()

    private var realm: Realm?

    private init() {
        let config = Realm.Configuration(schemaVersion: 2, migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                    newObject?["startTime"] = Date()
                }
            }
        })
        do {
            realm = try Realm(configuration: config)
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }

    func getRealm() -> Realm {
        return realm!
    }
}
