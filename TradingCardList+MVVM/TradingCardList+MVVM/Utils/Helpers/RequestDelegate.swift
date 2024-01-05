//
//  RequestDelegate.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import Foundation

// ViewModel은 View에 대해 알 필요가 없다!
// 상태가 변했다는 것을 View에게 알려주기만 하면 되고, 이걸 delegate로 구현

protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
