//
//  UITableViewCell.swift
//  TradingCardList+MVVM
//
//  Created by yeonsu on 1/5/24.
//

import UIKit

public extension UITableViewCell {
    
    /** Return identifier with the same name of the subclass */
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
