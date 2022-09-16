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
    // text view를 클릭할 경우 키패드 만큼 view bottom이 올라가야 하기 때문에 지정
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var isTodayButton: UIButton!

    
    @IBOutlet weak var addButton: UIButton!
    //TODO: TodoViewModel 만들기
    let todoListViewModel = TodoViewModel()
    
    
    
    // 📌 키보드 디텍션 구현
    // 키보드가 올라오고 내려가는 것을 관찰
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    // observer(관찰자): TodoListViewController 스스로
    // selector: 관찰이 되면 어떤 메소드를 실행할 것인지 선택
    // name: 관찰하고자 하는 이벤트의 이름 -> UIResponder.keyboardWillShowNotificationobject: nil로 지정

        //NotificationCenter.default.addObserver를 통해 올라오는 키패드 관찰
        
        //키패드가 올라오거나 내려갈 경우 adjustInputView 호출
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        //  관찰을 self 가하고 UIResponder.keyboardWillShowNotification가 감지되면 selector 메소드 실행
        
        
        
        //TODO: 데이터 불러오기
        todoListViewModel.loadTasks()
    }

    

    @IBAction func isTodayButtonTapped(_ sender: Any) {
        //TODO: 투데이 버튼 토글 작업
        // 버튼을 누르는 행위: 눌리는 상태를 저장할 변수(outlet)와 누르는 행위(action)이 존재
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        //TODO: Task 추가
        //add task to view model
        //and tableview reload or update
        
        // MARK: add (+) 버튼이 눌렸을 때 할 일
        /*
         1. TextField에 text 존재 여부 판단
         2. createTodo 호출 -> todo 객체 생성
         3. todoListViewModel에 더하기
         4. collectionView reload -> ViewModel에 있는 추가된 데이터들이 CollectionView에 표시
         5. inputTextView, isTodayButton을 default값으로 리셋
         */
        
        guard let detail = inputTextField.text, detail.isEmpty == false else {return}
        
        let todo = TodoManager.shared.createTodo(detail: detail, isToday: isTodayButton.isSelected)
        todoListViewModel.addTodo(todo)
        collectionView.reloadData()
        inputTextField.text = ""
        isTodayButton.isSelected = false
    }
    
    
    //TODO: background tap했을 때 키보드 내려오게 하기
    // Tap Gesture Recognizer: 키패드와 Textfield를 제외한 부분을 눌렀을 때 키패드를 내림 -> Tap Gesture Recognizer를 object Library를 전체 View에 삽입

    // inputTextField.resignFirstResponder(): 현재 First하게 응답하는 것이 Textfield이기 때문에 집중되어 있는 상태를 resign한다는 기능(textfield가 우선 순위에서 내려감)
    
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()
    }
}


// detection한 키보드 높이에 따른 인풋뷰 위치 변경 기능 구현
extension TodoListViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        
        
        // noti: 감지한 내용
        // 키보드 프레임 정보(키보드의 위치와 사이즈): userInfo[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?  NSValue)?.cgRectValue else {return}
        
        // iPhone의 safeArea만큼 Height 값 빼줌
        // keyboardFrame.height - view.safeAreaInsets.bottom
        if noti.name == UIResponder.keyboardWillShowNotification{
            let adjusmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            inputViewBottom.constant = adjusmentHeight
        }else{
            inputViewBottom.constant = 0 // 키보드가 사라질 때는 다시 0으로 초기화
        }
                
        print("--> Keyboard End Frame : \(keyboardFrame)")
        
    }
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
        // TODO: 섹션별 아이템 몇개
        if section == 0{
            return todoListViewModel.todayTodos.count
        }else{
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
            todo = todoListViewModel.upcomingTodos[indexPath.item]
        }
        
        cell.updateUI(todo: todo)
        //TODO: custom cell
        //TODO: todo를 이용해서 updateUI
        
        //TODO: doneButtonHandler 작성
        //TODO: deleteButtonHandler 작성
        cell.doneButtonTapHandler = { isDone in todo.isDone = isDone
            self.todoListViewModel.updateTodo(todo)
            self.collectionView.reloadData()
        }
        
        cell.deleteButtonTapHandler = {
            self.todoListViewModel.deleteTodo(todo)
            self.collectionView.reloadData()
        }
        
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
    
    @IBAction func deleteButtonTapped(_ sender: Any) {        //TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
}

class TodoListHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


