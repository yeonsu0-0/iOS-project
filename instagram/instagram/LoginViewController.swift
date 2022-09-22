//
//  LoginViewController.swift
//  instagram
//
//  Created by yeonsu on 2022/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? " "
        self.email = text
        print(text)
    }
    
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? " "
        self.password = text
    }
    
    
}
