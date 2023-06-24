//
//  ArticleService.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import Foundation
import Alamofire
import RxSwift

class ArticleService {
    
    // RxSwift는 Swift에서 반응형 프로그래밍을 구현하기 위한 라이브러리로, 옵저버블과 옵저버를 통해 데이터의 흐름과 비동기 작업을 처리할 수 있게 도와줌
    // RxSwift를 이용해서 콜백 지옥에서 벗어나 비동기 처리를 함수의 반환값으로 만들기
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            self.fetchNews{(error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                if let articles = articles {
                    observer.onNext(articles)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    // error 또는 article을 반환해주는 콜백 함수
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> (Void))) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-05-24&sortBy=publishedAt&apiKey=122d399d6198434c991a8020bca2c14f"
        
        guard let url = URL(string: urlString) else {return completion(NSError(domain: "yeonsu", code: 404, userInfo: nil), nil)}
        
        // get data
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseDecodable(of: ArticleResponse.self) { response in
            if let error = response.error {
                return completion(error, nil)
            }
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
        }
    }
}
