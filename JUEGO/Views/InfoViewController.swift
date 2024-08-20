//
//  InfoViewController.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imvVolume: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleMute(_ sender: UIButton) {
        if SoundManager.shared.isMuted {
            SoundManager.shared.unmute()
            imvVolume.image = UIImage(systemName: "speaker.fill")
        } else {
            SoundManager.shared.mute()
            imvVolume.image = UIImage(systemName: "speaker.slash.fill")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
