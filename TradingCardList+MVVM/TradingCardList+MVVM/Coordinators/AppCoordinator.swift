//
//  AppCoordinator.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import UIKit

/// The AppCoordinator is our first coordinator
/// In this example the AppCoordinator as a rootViewController
class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    
    /// Remember to change the UIViewController instance to your Splash Screen
    private(set) var rootViewController: UIViewController = SplashController() {
        didSet {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = self.rootViewController
            })
        }
    }
    
    /// Window to manage
    let window: UIWindow
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    private func setCurrentCoordinator(_ coordinator: RootViewCoordinator) {
        rootViewController = coordinator.rootViewController
    }
    
    /// Starts the coordinator
    func start() {
        let homeCoordinator = HomeCoordinator()
        addChildCoordinator(homeCoordinator)
        setCurrentCoordinator(homeCoordinator)
    }
}
