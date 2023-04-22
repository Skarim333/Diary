//
//  AppCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let MainCoordinator = MainCoordinator(navigationController: navigationController)
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
