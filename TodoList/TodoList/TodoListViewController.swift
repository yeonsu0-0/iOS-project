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
    
    
}
