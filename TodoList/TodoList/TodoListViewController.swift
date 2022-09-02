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


// ================ 📌 이해 안 되는 부분 ================

// UICollectionViewDataSource
// 컬렉션뷰의 데이터를 관리하고 해당 데이터를 표현하는데 필요한 화면을 구현함

extension TodoListViewController: UICollectionViewDataSource {
    //TODO: 섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return todoListViewModel.numOfSection
    }
    //TODO: 섹션별 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return todoListViewModel.todayTodos.count
        } else {
            return todoListViewModel.upcomingTodos.count
        }
    }
    
    //TODO: custom cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell()
        }
        
        var todo : Todo
        if indexPath.section == 0 {
            todo = todoListViewModel.todayTodos[indexPath.item]
        }else {
            todo = todoListViewModel.upcompingTodos[indexPath.item]
        }
        
        cell.updateUI(todo: todo)
        //TODO: custom cell
        //TODO: todo를 이용해서 updateUI
        //TODO: doneButtonHandler 작성
        //TODO: deleteButtonHandler 작성
        
        return cell

    }
// ================ 📌 이해 안 되는 부분 ================
    // HeaderView
    // UICollectionReusableView
    
    // kind라는 인자로 해당 View의 종류가 HeaderView인지 FooterView인지 알 수 있음
    
    //  📌 switch문을 통해 kind의 종류가 UICollectionView.elementKindSectionHeader인지 확인 -> 재사용되는 HeaderView 지정 -> indexPath에 해당되는 section을 section 변수에 넣어 title을 headerView의 sectionTitleLabel.text에 넣어서 업데이트 된 header을 반환함
    
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

// UICollectionViewDelegateFlowLayout

// The methods of this protocol define the size of items and the spacing between items in the grid.

// 셀의 크기 계산

// 📌 CGSize, CGFloat 객체로 반환
extension TodoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: 사이즈 계산하기
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat =  50
        return CGSize(width: width, height: height)
    }
}
// ================================================


// TodoListCell: collectionView에서 사용할 custom Cell이다

// Cell에 필요한 3가지 기능
// 1. check button을 누름에 따라 delete button이 등장하고, Label이 짝대기(strikeThrougView)와 함께 흐려진다
// 2. delete button을 누르면 삭제되는 기능
// 3. UI update 기능


class TodoListCell: UICollectionViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var strikeThroughView: UILabel!
    
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
// ================ 📌 이해 안 되는 부분 ================
    
    // check가 되었을 때 또는 삭제 버튼을 눌렀을 때 객체에게 check됨, 삭제 한다는 것을 알려야하는데, 그 로직을 처리하기 위한 변수를 선언함
    
    // Cell(View)객체 안에 있는 method이기 때문에 View 객체가 다른 비지니스 로직을 건드리지 않도록 하기 위해 클로져로 만듬 -> 외부에서 필요한 로직 구현
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    // awakeFromNib: 화면이 Storyboard에서 띄워졌을 때
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    // prepareForReuse: 재사용을 준비할 때
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
 // ================================================
    
    // UI 업데이트
    func updateUI(todo: Todo) {
        //TODO: cell update
        
        // isDone으로 체크 여부 판단
        checkButton.isSelected = todo.isDone
        
        // todo 설명 텍스트
        descriptionLabel.text = todo.detail
        
        //  📌 alpha 프로퍼티: 선명도를 나타내는 요소
        //  The value of this property is a floating-point number in the range 0.0 to 1.0, where 0.0 represents totally transparent and 1.0 represents totally opaque.
        descriptionLabel.alpha = todo.isDone ? 0.2 : 1
        
        // 삭제 버튼은 선택되지 않은 cell에서 숨겨진 상태
        deleteButton.isHidden = todo.isDone == false
        
        // 체크된 todo는 짝대기 긋기
        showStrikeThrough(todo.isDone)
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
    
    // 📌 CollectionView와 TableView의 Cell은 재사용됨
    // But, 체크 버튼이 눌려있거나, text가 투명해지거나, deleteButton이 있다 없거나 하면 예기치 못한 오류 발생 -> default 상태를 만듬
    
    func reset() {
        //TODO: reset logic 구현
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false)
    }
    
    // 체크 버튼 처리
    @IBAction func checkButtonTapped(_ sender: Any) {
        //TODO: checkButton 처리
        
        // check button이 눌렸을 때 눌린 상태인 isSelected는 반전됨
        checkButton.isSelected = !checkButton.isSelected
        let isDone = checkButton.isSelected
        descriptionLabel.alpha = isDone ? 0.2 : 1
        deleteButton.isHidden = !isDone
        
        // 실제 데이터에 대한 변경은 Closure 담당
        doneButtonTapHandler?(isDone)
    }
    
    // delete 버튼 눌렸을 때 처리 방식: cell은 View 객체이기 때문에 TodoManager이 해당 데이터를 지운 다음에 View에서 업데이트 된 데이터를 다시 불러오는 방법이 좋다!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        //TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
}

