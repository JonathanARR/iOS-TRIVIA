//
//  GameViewController.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var lblQuestionIndex: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblLives: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnA1: UIButton!
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    @IBOutlet weak var btnA4: UIButton!
    @IBOutlet weak var imvAlarm: UIImageView!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
