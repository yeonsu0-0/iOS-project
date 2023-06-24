//
//  ArticleService.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import Foundation
import Alamofire

class ArticleService {
    
    
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
