//
//  UIView+Extension.swift
//  instagram
//
//  Created by yeonsu on 2022/10/08.
//

import UIKit

@IBDesignable
extension UIView {      //extension으로 UIView 확장
    
    // 📌 @IBInspectable: inspector 영역에서 해당 인터페이스 요소의 속성을 변경할 수 있게 하는 것
    @IBInspectable var cornerRadius: CGFloat {
        // 연산 프로퍼티
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
