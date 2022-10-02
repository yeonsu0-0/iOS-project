//
//  RegisterViewController.swift
//  instagram
//
//  Created by yeonsu on 2022/09/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    // 유효성 검사
    // textfield에서 유효한 값이 입력되는 경우 true로 값 변경
    var isValidEmail = false
    var isValidName = false
    var isValidNickname = false
    var isValidPassword = false
    
    // Textfields
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    //
    var textFields: [UITextField] {
        [emailTextfield, nameTextfield, nicknameTextfield, passwordTextfield]
    }
    
    // MARK: - Lifecycle
    
    
    // =================================================
    // 📌 viewDidLoad() 메서드
    // viewController의 view가 메모리에 로드된 후 호출
    
    // viewDidLoad() 메서드가 일종의 초기화 역할을 한다고 가정하면, super class에서 올바르게 설정하기 위해 먼저 super.viewDidLoad()를 호출해야 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // =================================================

    
    // MARK: - Actions
    // action을 코드로 작성
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextfield:
            print("email")
        case nameTextfield:
            print("name")
        case nicknameTextfield:
            print("nickname")
        case passwordTextfield:
            print("password")
        default:
            fatalError("Missing TextField... :(")
            
        }
    }
    
    
    // MARK: = Helpers

    // textField와 action 연결
    private func setupTextField() {
        
         emailTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         nameTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         nicknameTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         
         passwordTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         }
         
        
        // 📌 forEach: 위의 긴 코드들을 한 번에 쓸 수 있는 코드
        // 식별된 데이터의 콜렉션으로부터 요구에 따라 뷰를 계산해주는 구조체
//        textFields.forEach{tf in
//            tf.addTarget(self,
//                         action: #selector(textFieldEditingChanged(_:)),
//                         for: .editingChanged)
//        }
        
    }
