//
//  ViewState.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
