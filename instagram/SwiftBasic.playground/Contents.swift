import UIKit

//
// 1. 변수와 상수 선언
// 1-1. 상수
let name: String = "Bonny"
let swift = "Swift"     //타입 추론

// 1-2. 변수
var year: Int = 2022
var month = 9           //타입 추론
year = 2023
//
//
// 2. 함수
func sum(a: Int, b: Int) -> Int {
    return a + b        //return 생략 가능
}
sum(a:1, b:2)
//
//
// 3. 이름 짓기
// 3-1. Lower Camel Case - 인스턴스 / 메소드 / 함수
let viewController = UIViewController()     //인스턴스 생성

// 3-2. Upper Camel Case - 구조체 / 클래스 / 프로토콜
struct Person {             //구조체: 초기화 함수 자동 생성
    let a: Int
    let b: Int
}

class Operator {            //클래스: 초기화 함수 자동 생성 XXX
    let a: Int
    let b: Int
    
    init(a: Int, b: Int) {  //초기화 함수 선언
        self.a = a
        self.b = b
    }
}

// 프로토콜의 구현은 해당 프로토콜을 채택한 클래스, 구조체의 객체가 직접 구현
protocol Flyable {
    func fly()
}
