//
//  ViewController.swift
//  printName
//
//  Created by yeonsu on 2022/09/20.
//

import UIKit

class ViewController: UIViewController {

    // 초기값이 없어서 옵셔널 (!)
    @IBOutlet weak var IBHello: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    // txtName.text는 옵셔널 string
    @IBAction func sendBtn(_ sender: UIButton) {
        IBHello.text = "행복한 하루 보내세요, " + txtName.text!
    }
    
}

