//
//  MainCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

@available(iOS 13.0, *)
final class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    private let navigationController: UINavigationController
    
    private let taskManager: TaskManager
    
    init(navigationController: UINavigationController, taskManager: TaskManager) {
        self.navigationController = navigationController
        self.taskManager = taskManager
    }
    
    func start() {
        let vc = MainModuleAssembly.createModule(taskManager: taskManager, output: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

@available(iOS 13.0, *)
extension MainCoordinator: MainViewModelOutput {
    
    func startAddScene() {
        let addCoordinator = AddCoordinator(navigationController: navigationController, taskManager: taskManager)
        addCoordinator.parentCoordinator = self
        childCoordinators.append(addCoordinator)
        addCoordinator.start()
    }
    func startEditingScene(_ task: Task) {
        let addCoordinator = AddCoordinator(navigationController: navigationController, taskManager: taskManager)
        addCoordinator.parentCoordinator = self
        childCoordinators.append(addCoordinator)
        addCoordinator.start()
    }
}
