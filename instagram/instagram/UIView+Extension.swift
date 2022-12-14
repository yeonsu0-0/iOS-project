//
//  UIView+Extension.swift
//  instagram
//
//  Created by yeonsu on 2022/10/08.
//

import UIKit

@IBDesignable
extension UIView {      //extensionμΌλ‘ UIView νμ₯
    
    // π @IBInspectable: inspector μμ­μμ ν΄λΉ μΈν°νμ΄μ€ μμμ μμ±μ λ³κ²½ν  μ μκ² νλ κ²
    @IBInspectable var cornerRadius: CGFloat {
        // μ°μ° νλ‘νΌν°
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
