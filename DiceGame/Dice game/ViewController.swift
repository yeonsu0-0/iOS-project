//
//  ViewController.swift
//  Dice game
//
//  Created by yeonsu on 8/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    //주사위 변수 선언
    var leftDiceNum = 1
    var rightDiceNum = 5
    var dices: Array =  [ #imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    


    @IBAction func rollTheDiceButton(_ sender: UIButton) {


        diceImageView1.image = dices.randomElement()
        diceImageView2.image = dices[Int.random(in: 0...5)]

        
        //random number 구현
        //Int.random(in: 1...10)
        //dices.randomElement()
        
    }
}



