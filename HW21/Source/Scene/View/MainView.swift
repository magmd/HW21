import UIKit

class MainView: UIView {

    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    lazy var btn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())

        return btn
    }()

    lazy var passwordGenerateButton: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())
        btn.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        btn.setTitleColor(.white, for: .normal)

        return btn
    }()

    lazy var bruteforceButton: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())
        btn.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        btn.setTitleColor(.white, for: .normal)

        return btn
    }()

    lazy var bruteforceStopButton: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())
        btn.tintColor = .black
        btn.setTitleColor(.white, for: .normal)

        return btn
    }()

    lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 20)
        field.clearButtonMode = .whileEditing

        return field
    }()

    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)

        return label
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .gray

        return indicator
    }()

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        self.addSubview(mainView)

        mainView.addSubview(passwordLabel)
        mainView.addSubview(activityIndicator)
        mainView.addSubview(textField)
        mainView.addSubview(btn)
        mainView.addSubview(passwordGenerateButton)
        mainView.addSubview(bruteforceButton)
    }

    private func setupLayout() {
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100).isActive = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 100).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        btn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 270).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true

        passwordGenerateButton.translatesAutoresizingMaskIntoConstraints = false
        passwordGenerateButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        passwordGenerateButton.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 10).isActive = true
        passwordGenerateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordGenerateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        bruteforceButton.translatesAutoresizingMaskIntoConstraints = false
        bruteforceButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        bruteforceButton.topAnchor.constraint(equalTo: passwordGenerateButton.bottomAnchor, constant: 10).isActive = true
        bruteforceButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bruteforceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
