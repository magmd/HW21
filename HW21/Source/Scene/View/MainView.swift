import UIKit

class MainView: UIView {

    var isBlack: Bool = false {
        didSet {
            if isBlack {
                mainView.backgroundColor = .black
            } else {
                mainView.backgroundColor = .white
            }
        }
    }

    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private lazy var btn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())
        btn.setTitle("Submit", for: .normal)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)

        return btn
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
        setupView()
    }

    private func setupHierarchy() {
        self.addSubview(mainView)
        mainView.addSubview(btn)
    }

    private func setupLayout() {
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupView() {

    }

    @objc func btnTapped(sender: UIButton) {
        isBlack.toggle()
    }
}

