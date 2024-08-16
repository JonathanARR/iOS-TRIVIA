import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var imvAvatar: UIImageView!
    @IBOutlet weak var txfNickname: UITextField!
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txfNickname.delegate = self
        txfNickname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        updateStartButtonState(isEnabled: false) // Inicializar el botón como deshabilitado
    }
    
    override func viewDidLayoutSubviews() {
        viewAvatar.makeRoundView()
        viewAvatar.layer.borderWidth = 7.5
        viewAvatar.layer.borderColor = UIColor.systemYellow.cgColor
        
        btnStart.makeRoundView(cornerRadius: 5.0)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, isValidNickname(text) {
            updateStartButtonState(isEnabled: true)
        } else {
            updateStartButtonState(isEnabled: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txfNickname {
            startGame(btnStart)
            textField.resignFirstResponder() // Oculta el teclado
        }
        return true
    }
    
    func isValidNickname(_ nickname: String) -> Bool {
        let regex = "^[a-zA-Z0-9]{4,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: nickname)
    }
    
    func updateStartButtonState(isEnabled: Bool) {
        btnStart.isEnabled = isEnabled
        if isEnabled {
            btnStart.backgroundColor = UIColor.white
            btnStart.setTitleColor(UIColor.systemIndigo, for: .normal)
        } else {
            btnStart.backgroundColor = UIColor.lightGray
            btnStart.setTitleColor(UIColor.darkGray, for: .disabled)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.alphanumerics
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgStart" {
            guard let startVC = segue.destination as? StartViewController else { return }
            let playerName = txfNickname.text ?? ""
            let player = Player(name: playerName, score: 0)
            startVC.player = player
        }
    }

    @IBAction func startGame(_ sender: UIButton) {
        if self.isViewLoaded && (self.view.window != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let startVC = storyboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else {
                print("ERROR")
                return
            }

            let player = Player(name: txfNickname.text ?? "N", score: 0)
            startVC.player = player
            let navigationController = UINavigationController(rootViewController: startVC)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.setNavigationBarHidden(true, animated: false)
            
            SoundManager.shared.stopBackgroundMusic()
            
            self.present(navigationController, animated: true, completion: nil)
        } else {
            print("MenuViewController no está completamente cargado o visible")
        }
    }

}

extension UIView {
    func makeRoundView(cornerRadius: CGFloat? = nil) {
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = self.frame.size.width / 2.0
        }
        self.clipsToBounds = true
    }
}

extension UIButton {
    func makeRoundButton(cornerRadius: CGFloat? = nil) {
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = self.frame.size.width / 2.0
        }
        self.clipsToBounds = true
    }
}
