import UIKit

protocol AvatarsViewControllerDelegate: AnyObject {
    func didSelectAvatar(_ avatarName: String)
}

class AvatarsViewController: UIViewController {

    @IBOutlet weak var scrAvatarsIndex: UIScrollView!
    
    private let viewContent = UIView()
    
    var avatars = ["avatar0.png", "avatar1.png", "avatar2.png", "avatar3.png", "avatar4.png", "avatar5.png", "avatar6.png", "avatar7.png", "avatar8.png", "avatar9.png", "avatar10.png", "avatar11.png", "avatar12.png", "avatar13.png"]
    
    weak var delegate: AvatarsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewContent()
        addAvatarViews(avatars: avatars)
    }

    func setUpViewContent() {
        scrAvatarsIndex.addSubview(viewContent)
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewContent.leadingAnchor.constraint(equalTo: scrAvatarsIndex.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrAvatarsIndex.trailingAnchor),
            viewContent.topAnchor.constraint(equalTo: scrAvatarsIndex.topAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrAvatarsIndex.bottomAnchor),
            viewContent.widthAnchor.constraint(equalTo: scrAvatarsIndex.widthAnchor)
        ])
    }
    
    func addAvatarViews(avatars: [String]) {
        viewContent.subviews.forEach { $0.removeFromSuperview() }
        
        for (i, avatar) in avatars.enumerated() {
            let avatarView = UIView()
            avatarView.backgroundColor = .systemPink
            avatarView.layer.borderWidth = 5.0
            avatarView.layer.borderColor = UIColor.yellow.cgColor
            avatarView.translatesAutoresizingMaskIntoConstraints = false
            viewContent.addSubview(avatarView)
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: avatar)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            avatarView.addSubview(imageView)
            
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            avatarView.addSubview(button)
            
            let row = i / 2
            let column = i % 2
            
            NSLayoutConstraint.activate([
                avatarView.widthAnchor.constraint(equalTo: scrAvatarsIndex.widthAnchor, multiplier: 0.4),
                avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor, multiplier: 1.0),
                column == 0 ?
                    avatarView.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 20) :
                    avatarView.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -20),
                avatarView.topAnchor.constraint(equalTo: row == 0 ? viewContent.topAnchor : viewContent.subviews[(row * 2) - 1].bottomAnchor, constant: 20),
                
                imageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
                
                button.topAnchor.constraint(equalTo: avatarView.topAnchor),
                button.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
                button.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor)
            ])
            
            if i == avatars.count - 1 {
                avatarView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -20).isActive = true
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let selectedAvatar = avatars[sender.tag]
        delegate?.didSelectAvatar(selectedAvatar)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewContent.subviews.forEach { view in
            view.makeRoundView()
        }
    }
}
