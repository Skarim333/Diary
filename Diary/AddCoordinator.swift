//
//  AddCoordinator.swift
//  Diary
//
//  Created by Карим Садыков on 21.04.2023.
//

import UIKit

final class AddCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: MainCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let addViewController = AddViewController()
        let addViewModel = AddViewModel()
        addViewModel.coordinator = self
        addViewController.viewModel = addViewModel
        navigationController.pushViewController(addViewController, animated: true)
    }
    
    func didFinishAddScene() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
}
