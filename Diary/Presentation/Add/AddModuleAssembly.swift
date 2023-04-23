//
//  AddModuleAssembly.swift
//  Diary
//
//  Created by Карим Садыков on 23.04.2023.
//

import UIKit

@available(iOS 13.0, *)
final class AddModuleAssembly {
    static func createModule(taskManager: TaskManager, task: Task? = nil, output: AddViewModelOutput?) -> UIViewController {
        let addViewModel = AddViewModel(taskManager: taskManager, task: task, output: output)
        let addVC = AddViewController(viewModel: addViewModel)
        return addVC
    }
}
