import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {

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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, isValidNickname(text) {
            updateStartButtonState(isEnabled: true)
        } else {
            updateStartButtonState(isEnabled: false)
        }
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
        // Asegúrate de que el segue esté correctamente conectado en el storyboard
        if self.isViewLoaded && (self.view.window != nil) {
            performSegue(withIdentifier: "sgStart", sender: self)
        } else {
            print("MenuViewController no está completamente cargado o visible")
        }
    }
}
