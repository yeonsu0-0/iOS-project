//
//  LoginViewController.swift
//  instagram
//
//  Created by yeonsu on 2022/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var isSignupButton: UIButton!
    
    
    // 입력받은 값을 저장할 멤버 변수
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        
        // border-radius 속성을 코드로 구현
        loginButton.layer.cornerRadius = 8
    }
    
    
    private func setupAttributes() {
        
        // isSignupButton
        // 한 label에 있는 텍스트 컬러 다르게 하기
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 18)
        let font2 = UIFont.boldSystemFont(ofSize: 18)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.systemPink
        
        let attributes = generateButtonAttribute(self.isSignupButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        
        self.isSignupButton.setAttributedTitle(attributes, for: .normal)
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
