import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let jiSungView = JiSungView()

    override func loadView() {
        view = jiSungView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
