//
//  AddCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

@available(iOS 13.0, *)
final class AddCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    private let navigationController: UINavigationController
    
    private let taskManager: TaskManager
    
    init(navigationController: UINavigationController, taskManager: TaskManager) {
        self.navigationController = navigationController
        self.taskManager = taskManager
    }
    
    func start() {
        let vc = AddModuleAssembly.createModule(taskManager: taskManager, output: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startEditing(_ task: Task) {
        let vc = AddModuleAssembly.createModule(taskManager: taskManager, task: task, output: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

@available(iOS 13.0, *)
extension AddCoordinator: AddViewModelOutput {
    func didFinishAddScene() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
}
