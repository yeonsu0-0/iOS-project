//
//  Environment.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import Foundation

extension Environment {
    enum Variable: String {
        case appName = "APP_NAME"
        case appBundleID = "APP_BUNDLE_ID"
    }
}

struct Environment {
    static func getValue(forKey key: Variable) -> String {
        return infoForKey(key.rawValue)
    }
    
    private static func infoForKey(_ key: String) -> String {
        guard let value = (Bundle.main.infoDictionary?[key] as? String) else {
            fatalError("Could not get value for key: \(key)")
        }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}
