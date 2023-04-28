//
//  ResultViewController.swift
//  QnA
//
//  Created by 張凱棋 on 2023/4/26.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultImg: UIImageView!
    @IBOutlet weak var scoreBg: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "你的分數是"
        scoreLabel.text = "\(score)分"
        if score >= 60 {
            resultImg.image = UIImage(named: "correct.png")
            scoreBg.backgroundColor = .systemRed
        }
        else{
            resultImg.image = UIImage(named: "sad.png")
            scoreBg.backgroundColor = .systemIndigo
        }
    }
    
    
}
