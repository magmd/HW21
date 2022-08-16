import UIKit

final class MainController: UIViewController {

    var isBlack: Bool = false {
        didSet {
            if isBlack {
                mainView?.mainView.backgroundColor = .black
                mainView?.passwordLabel.textColor = .white
            } else {
                mainView?.mainView.backgroundColor = .white
                mainView?.passwordLabel.textColor = .black
            }
        }
    }

    let queue = DispatchQueue(label: Constants.queueString, qos: .utility)
    var isBruteForce = false

    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = MainView()
        setInitConstants()
        actionForButtons()
    }
}

extension MainController {

    private func actionForButtons() {
        mainView?.btn.addTarget(self, action: #selector(MainController().btnTapped), for: .touchUpInside)
        mainView?.passwordGenerateButton.addTarget(self, action: #selector(passwordGenerate), for: .touchUpInside)
        mainView?.bruteforceButton.addTarget(self, action: #selector(bruteForcePassword), for: .touchUpInside)
    }

    private func setInitConstants() {
        mainView?.passwordLabel.text = Constants.passwordLabel
        mainView?.textField.text = Constants.defaultTextFieldString
        mainView?.textField.placeholder = Constants.fieldPlaceholder

        setButtonText()
    }

    private func setButtonText() {
        mainView?.passwordGenerateButton.setTitle(Constants.buttonGeneratePassword, for: .normal)
        mainView?.btn.setTitle(Constants.buttonChangeColor, for: .normal)
        mainView?.bruteforceButton.setTitle(Constants.bruteforceString, for: .normal)
        mainView?.bruteforceStopButton.setTitle(Constants.stopButtonString, for: .normal)
    }

    private func toStoppedButton() {
        mainView?.bruteforceButton.setTitle(Constants.stopButtonString, for: .normal)
        mainView?.bruteforceButton.tintColor = .brown
    }

    private func toBruteForceButton() {
        mainView?.bruteforceButton.setTitle(Constants.bruteforceString, for: .normal)
        mainView?.bruteforceButton.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }

    @objc func btnTapped(sender: UIButton) {
        isBlack.toggle()
    }

    @objc func passwordGenerate(sender: UIButton) {
        let letters = String().printable
        mainView?.textField.text = String((0..<3).map{ _ in letters.randomElement()! })
    }

    @objc func bruteForcePassword(sender: UIButton) {
        let password = mainView?.textField.text ?? ""

        if password.isEmpty {
            mainView?.passwordLabel.text = "Empty password"
        } else {
            if isBruteForce {
                isBruteForce = false
                toBruteForceButton()
            } else {
                mainView?.activityIndicator.startAnimating()
                mainView?.passwordGenerateButton.isUserInteractionEnabled = false
                mainView?.textField.isUserInteractionEnabled = false
                toStoppedButton()
                isBruteForce = true
            }
            queue.async {
                self.bruteForce(passwordToUnlock: password)
            }
        }
    }
}

extension MainController {

    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {

            if !self.isBruteForce {
                break
            }

            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)

            DispatchQueue.main.async {
                self.mainView?.passwordLabel.text = password
            }

            print(password)
        }

        DispatchQueue.main.async {
            if self.isBruteForce {
                self.toBruteForceButton()
                self.isBruteForce = false
                self.mainView?.passwordLabel.text = "Password cracked - \(passwordToUnlock)"
            } else {
                self.mainView?.passwordLabel.text = "Couldn't crack - \(passwordToUnlock)"
            }

            self.mainView?.passwordGenerateButton.isUserInteractionEnabled = true
            self.mainView?.textField.isUserInteractionEnabled = true
            self.mainView?.activityIndicator.stopAnimating()
        }

    }

    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}
