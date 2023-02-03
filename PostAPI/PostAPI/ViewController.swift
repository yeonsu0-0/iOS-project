//
//  ViewController.swift
//  PostAPI
//
//  Created by yeonsu on 2023/02/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        postAPI()
    }
    
    // postAPI
    
    func postAPI() {
        
        let url = URL(string: "https://trains.p.rapidapi.com/")
        guard url != nil else {
            print ("Error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let headers = [
            "content-type": "application/json",
            "X-RapidAPI-Key": "603bd209acmsh1412f2fe51baddep196a81jsn88b5524f5eb5",
            "X-RapidAPI-Host": "trains.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        
        let requestObject = ["search": "Rajdhani"] as [String : Any]
        
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: requestObject, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print("error")
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, responce, error in
            do {
                let parsingData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(parsingData)
            } catch {
                print("Parsing Error")
            }
        }
        dataTask.resume()
    }


}

