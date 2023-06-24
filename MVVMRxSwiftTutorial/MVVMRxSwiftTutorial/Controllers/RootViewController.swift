//
//  RootViewController.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    // MARK: - Life Cycles
    init(viewModel:RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
    }

    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: {articles in
            print(articles)
        }).disposed(by: disposeBag)
    }
}
