//
//  ToDo.swift
//  TodoList
//
//  Created by yeonsu on 8/21/22.
//

import Foundation


// 사용할 데이터의 형식을 struct로 선언
struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    // 업데이트 메서드
    mutating func update(isDone: Bool, detail: String, isToday: Bool){
        // TODO: 업데이트 로직 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    // 📌 연산자 오버로딩 (이해 못함)
    // 연산자 오버로딩에서 ==의 경우 Equatable를 상속받아야만 사용할 수 있다!
    // Codable은 데이터를 저장할 때 사용
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        //TODO: 동등 조건 추가
        return true
    }
}


// 데이터를 관리할 클래스(Todo 객체를 관리할 객체)
// 해야할 일이 여러개일 경우 이를 관리하는 객체가 따로 존재하는 것이 유지보수에 용이

// TodoManager은 TodoViewModel에서 사용하게 되고, TodoViewModel은 ViewController에서 사용하게 된다

class TodoManager {
    
    // 📌 ====
    // TodoManager가 single object이기 때문에 앱 내에서 여기저기 불려다닐 때 사용하는 객체
    static let shared = TodoManager()
    
    // todos 데이터의 개수를 계속 세면서 id를 메기기 보다는 lastId를 기록하는 것이 용이
    static var lastId: Int = 0
    
    // Todo 객체 데이터를 가지고 있음
    var todos: [Todo] = []
    // ========
    
    // 할 일 추가하기
    // detail(할 일 내용)과 Today 클릭 여부만 있다면 Todo 객체로 만들 수 있는 메서드
    func createTodo(detail: String, isToday: Bool) -> Todo {
        // TODO: create 로직 추가
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        return Todo(id: 1, isDone: false, detail: "2", isToday: true)
    }
    
    func addTodo(_ todo: Todo) {
        //TODO: add로직 추가
        // Todo객체가 들어오면 이를 todos에 넣음 -> json 파일에 출력하는 함수 호출
        todos.append(todo)
        saveTodo()
    }
    
    func deleteTodo(_ todo: Todo) {
        //TODO: delete 로직 추가
        // (1) id가 같은 데이터를 찾아서 해당 index의 데이터를 지우고 저장한다
        if let index = todos.firstIndex(of: todo) {
            todos.remove(at: index)
        }
        saveTodo()
        
        // 📌 (2) 가독성 좋게 작성하는 방법 (익숙해진 뒤 다시 돌아보자)
        //        todos = todos.filter({ existingTodo in
        //            return existingTodo.id != todo.id
        //        })
                
        //  todos = todos.filter{ $0.id != todo.id}
    }
    
    func updateTodo(_ todo: Todo) {
        //TODO: update 로직 추가
        guard let index = todos.firstIndex(of: todo) else {return}
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
    }
    
    // 📌
    // todos에 저장된 데이터를 json파일로 저장하는 메서드
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    // 📌
    // todos.json 파일에 저장된 데이터들을 각각 Todo 객체로 만들어서 todos에 집어넣는 메서드
    func retrieveTodo() {
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
    
}


class TodoViewModel {
    
    // 화면: Today / Upcoming 섹션 구분
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    // 📌
    // TodoManager를 적극 활용하기 때문에 shared를 변수로 선언
    private let manager = TodoManager.shared

    var todos: [Todo] {
        return manager.todos
    }

    var todayTodos: [Todo] {
        return todos.filter {$0.isToday == true}
    }
    
    var upcomingTodos: [Todo] {
        return todos.filter {$0.isToday == false}
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }

}

