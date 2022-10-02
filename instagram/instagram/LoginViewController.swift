//
//  LoginViewController.swift
//  instagram
//
//  Created by yeonsu on 2022/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 입력받은 값을 저장할 멤버 변수
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? " "   //옵셔널
        self.email = text
    }
    
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? " "
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
    }
    
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        
        // 화면 전환 로직
        // 스토리보드 생성 -> 뷰컨트롤러 생성 -> 화면 전환 메소드 이용해서 화면 전환
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // self.present(registerViewController, animated: true, completion: nil)
        
        // navigation controller push (embeded in 해서 사용)
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
