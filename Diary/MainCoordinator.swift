//
//  MainCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AppCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewModel.coordinator = self
        mainViewController.viewModel = mainViewModel
        navigationController.setViewControllers([mainViewController], animated: true)
    }
    
    func startAddScene() {
        let addCoordinator = AddCoordinator(navigationController: navigationController)
        addCoordinator.parentCoordinator = self
        childCoordinators.append(addCoordinator)
        addCoordinator.start()
    }
}
