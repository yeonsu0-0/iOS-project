//
//  TodoListViewController.swift
//  TodoList
//
//  Created by yeonsu on 8/20/22.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var isTodayButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    //TODO: TodoViewModel 만들기
    let todoListViewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO: 키보드 디텍션
        
        //TODO: 데이터 불러오기
        todoListViewModel.loadTasks()
    }

    

    @IBAction func isTodayButtonTapped(_ sender: Any) {
        //TODO: 투데이 버튼 토글 작업
    }
    
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        //TODO: Task 추가
        //add task to view model
        //and tableview reload or update
    }
    
    //TODO: background tap했을 때 키보드 내려오게 하기
}


// ===== 📌
// UICollectionViewDataSource
// 컬렉션뷰의 데이터를 관리하고 해당 데이터를 표현하는데 필요한 화면을 구현함

extension TodoListViewController: UICollectionViewDataSource {
    //TODO: 섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //TODO: 섹션별 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //TODO: custom cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: 커스텀 셀
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    //TODO: todo를 이용해서 updateUI
    //TODO: doneButtonHandler 작성
    //TODO: deleteButtonHandler 작성
    
    //헤더뷰
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodoListHeaderView", for: indexPath) as? TodoListHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = TodoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.sectionTitleLabel.text = section.title
            return header
        default:
            return UICollectionReusableView()
        }
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

