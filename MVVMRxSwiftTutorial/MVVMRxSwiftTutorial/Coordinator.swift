//
//  Coordinator.swift
//  MVVMRxSwiftTutorial
//
//  Created by bonny kim on 2023/06/24.
//

import UIKit

class Coordinator {
    
    // 스토리보드 없이 UI 구현
    let window: UIWindow
    
    /* window의 역할 */
    
    /*
     - 윈도우는 뷰들을 담는 컨테이너
     - 이벤트를 전달해주는 매개체
     - iOS 앱은 콘텐츠를 화면에 보여주기 위해 최소 1개 이상의 윈도우를 가짐
     */
 
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController()
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()  // 화면에 렌더링
    }
}
