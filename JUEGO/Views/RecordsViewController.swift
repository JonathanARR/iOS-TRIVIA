import UIKit

class RecordsViewController: UIViewController {

    @IBOutlet var viewsAvatars: [UIView]!
    @IBOutlet var imvAvatars: [UIImageView]!
    @IBOutlet var lblsNicknames: [UILabel]!
    @IBOutlet var lblsScores: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRecords()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in viewsAvatars {
            view.layoutIfNeeded()
        }
        
        for i in viewsAvatars {
            i.makeRoundView()
            i.layer.borderWidth = 3.5
            i.layer.borderColor = UIColor.white.cgColor
        }
    }

    func updateRecords() {
        let topRecords = RecordsManager.shared.getTopRecords()
        
        let numberOfRecords = min(topRecords.count, imvAvatars.count, lblsNicknames.count, lblsScores.count)
        
        for index in 0..<numberOfRecords {
            let player = topRecords[index]
            
            lblsNicknames[index].text = player.name
            lblsScores[index].text = "\(player.score)"
            
            if let avatarImage = UIImage(named: player.avatar) {
                imvAvatars[index].image = avatarImage
            } else {
                imvAvatars[index].image = UIImage(named: "avatar0.png")
            }
        }
    }
}
