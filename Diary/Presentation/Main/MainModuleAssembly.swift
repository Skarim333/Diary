//
//  MainModuleAssembly.swift
//  Diary
//
//  Created by Карим Садыков on 23.04.2023.
//

import UIKit

@available(iOS 13.0, *)
final class MainModuleAssembly {
    static func createModule(taskManager: TaskManager, output: MainViewModelOutput) -> UIViewController {
        let mainViewModel = MainViewModel(taskManager: taskManager, output: output)
        let mainVC = MainViewController(viewModel: mainViewModel)
        return mainVC
    }
}
