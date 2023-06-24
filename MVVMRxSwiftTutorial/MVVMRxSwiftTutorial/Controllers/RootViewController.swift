//
//  RootViewController.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties

    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
