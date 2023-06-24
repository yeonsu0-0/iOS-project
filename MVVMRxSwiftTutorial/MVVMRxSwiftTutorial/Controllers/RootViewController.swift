//
//  RootViewController.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleviewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }

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
        subscribe()
    }

    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    // MARK: - Helpers
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleviewModelObserver.subscribe(onNext: {articles in
            print(articles)
        }).disposed(by: disposeBag)
    }

}
