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
    
    private let articles = BehaviorRelay<[Article]>(value: [])
    // articles에 값이 들어올 때마다 관찰
    var articlesObserver: Observable<[Article]> {
        return articles.asObservable()
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
        self.viewModel.fetchArticles().subscribe(onNext: {articles in
            self.articles.accept(articles)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articlesObserver.subscribe(onNext: {articles in
            // collectionview를 생성할 때 collectionview.reloadData 함수 호출
        }).disposed(by: disposeBag)
    }
}
