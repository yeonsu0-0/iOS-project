//
//  RootViewModel.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import Foundation
import RxSwift

// 의존성 주입 기법
// root view에서 필요한 속성값 구현
final class RootViewModel {
    let title = "Daily News"
    
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[Article]> {
        articleService.fetchNews()
    }
}
