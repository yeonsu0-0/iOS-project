//
//  RegisterViewController.swift
//  instagram
//
//  Created by yeonsu on 2022/09/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var isLoginButton: UILabel!
    
    
    // MARK: - Properties
    // 유효성 검사
    // textfield에서 유효한 값이 입력되는 경우 true로 값 변경
    var isValidEmail = false {
        didSet {    // 프로퍼티 감시자
            self.valdateUserInfo()
        }
    }
    var isValidName = false {
        didSet {    // 프로퍼티 감시자
            self.valdateUserInfo()
        }
    }
    var isValidNickname = false {
        didSet {    // 프로퍼티 감시자
            self.valdateUserInfo()
        }
    }
    var isValidPassword = false {
        didSet {    // 프로퍼티 감시자
            self.valdateUserInfo()
        }
    }
    
    // Textfields
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    //
    var textFields: [UITextField] {
        [emailTextfield, nameTextfield, nicknameTextfield, passwordTextfield]
    }
    //
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    // MARK: - Lifecycle
    
    
    // =================================================
    // 📌 viewDidLoad() 메서드
    // viewController의 view가 메모리에 로드된 후 호출
    
    // viewDidLoad() 메서드가 일종의 초기화 역할을 한다고 가정하면, super class에서 올바르게 설정하기 위해 먼저 super.viewDidLoad()를 호출해야 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        
        setupAttribute()
    }
    // =================================================
    
    
    // MARK: - Actions
    // action을 코드로 작성
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextfield:
            self.isValidEmail = text.isVaildEmail()
        case nameTextfield:
            self.isValidName = text.count > 2
        case nicknameTextfield:
            self.isValidNickname = text.count > 2
        case passwordTextfield:
            self.isValidPassword = text.isValidPassword()
        default:
            fatalError("Missing TextField... :(")
            
        }
    }
    
    
    // MARK: = Helpers
    // textField와 action 연결
    private func setupTextField() {
        
        /*
         emailTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         nameTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         nicknameTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         passwordTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         }
         */
        
        // 📌 forEach: 위의 긴 코드들을 한 번에 쓸 수 있는 코드
        // 식별된 데이터의 콜렉션으로부터 요구에 따라 뷰를 계산해주는 구조체
        textFields.forEach{tf in
            tf.addTarget(self,
                         action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
    }
    
    
    
    // 사용자의 입력 정보를 확인한 뒤에 UI 업데이트
    private func valdateUserInfo() {
        if isValidEmail && isValidName && isValidNickname && isValidPassword {
            
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.blue
            }
        }
        else {  // 유효성 검사 -> 유효하지 않음
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.lightGray
            }
        }
    }
}



// =================================================
// 📌 정규 표현식
extension String {
    
    // 비밀번호 유효성 검사
    // 대문자, 소문자, 특수문자, 숫자 있는지 여부와, 8글자 이상일 때 -> true
    func isValidPassword() -> Bool {
    let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
    let passwordValidation = NSPredicate.init(format:"SELF MATCHES %@", regularExpression)
    
    return passwordValidation.evaluate(with: self)
    }
    
    // 이메일 유효성 검사
    //@포함하고 있는지 여부와, 2글자 이상일 때 -> true
    func isVaildEmail()-> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    private func setupAttributes() {
        
        // isLoginButton
        // 한 label에 있는 텍스트 컬러 다르게 하기
        
        let text1 = "계정이 있으신신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.systemBlue
        
        let attributes = generateButtonAttribute(self.isLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        
        self.isLoginButton.setAttributedTitle(attributes, for: .normal)
    }

}
// =================================================

