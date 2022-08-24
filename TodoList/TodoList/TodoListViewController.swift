//
//  TodoListViewController.swift
//  TodoList
//
//  Created by yeonsu on 8/20/22.
//

import UIKit

class TodoListViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class TodoListCell: UICollectionViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var strikeThroughView: UILabel!
    
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
// ================ 📌 이해 안 되는 부분 ================
    
    // check가 되었을 때, 또는 삭제 버튼을 눌렀을 때 객체에게 check됨, 삭제 한다는 것을 알려야하는데, 그 로직을 처리하기 위한 변수를 선언함
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
 // ================================================
    
    // UI 업데이트
    func updateUI(todo: Todo) {
        //TODO: cell update
    }
    
    // 취소 선
    // 만약 check버튼이 활성화 됐다면 넓이: 240, 아니라면 0
    private func showStrikeThrough(_ show: Bool) {
        if show {
            strikeThroughWidth.constant = descriptionLabel.bounds.width
        } else {
            strikeThroughWidth.constant = 0
        }
    }
    
    // 초기화
    func reset() {
        //TODO: reset logic 구현
    }
    
    // 체크 버튼 처리
    @IBAction func checkButtonTapped(_ sender: Any) {
        //TODO: checkButton 처리
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        //TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
}

