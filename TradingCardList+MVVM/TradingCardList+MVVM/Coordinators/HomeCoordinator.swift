//
//  HomeCoordinator.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import Foundation
import UIKit

class HomeCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private var navigationController: UINavigationController = {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }()
    
    func start() {}
}
