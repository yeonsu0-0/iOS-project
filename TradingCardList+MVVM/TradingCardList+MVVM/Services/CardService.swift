//
//  CardService.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import Foundation

final class CardService {
    
    static let baseURL = "https://db.ygoprodeck.com/api/v7"
    
    private enum Endpoint {
        case cardList
        // ...
        
        var path: String {
            switch self {
            case .cardList: return "/cardinfo.php"
            }
        }
        
        var url: String {
            switch self {
            case .cardList: return "\(baseURL)\(path)"
                // default: return ":"
            }
        }
    }
    
    static func getAllCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        // Network 연결 실패 시
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: Endpoint.cardList.url) else {
                completion(.failure(CustomError.noConnection))
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
                return
            }
            
            // 데이터가 없는 경우
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            
            do {
                let cards = try JSONDecoder().decode(CardResponse.self, from: data)
                completion(.success(cards.data))
            } catch let error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
            }
            
        }.resume()
    }
}
