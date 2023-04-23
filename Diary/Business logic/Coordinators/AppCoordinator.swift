//
//  AppCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

@available(iOS 13.0, *)
final class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let taskManager = TaskManager(realm: RealmService.shared.getRealm())
        let MainCoordinator = MainCoordinator(navigationController: navigationController, taskManager: taskManager)
        MainCoordinator.parentCoordinator = self
        childCoordinators.append(MainCoordinator)
        MainCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func didFinishAllMainScreens() {
        childCoordinators.removeAll()
        start()
    }
}
