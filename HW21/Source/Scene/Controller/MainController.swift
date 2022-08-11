import UIKit

final class MainController: UIViewController {

    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = MainView()
    }

}
