import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let jiSungContainerView = JiSungContainerView()

    override func loadView() {
        view = jiSungContainerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        jiSungContainerView.delegate = self
    }
}

extension JiSungViewController: JiSungContainerViewDelegate {
    func didTapGitHub() {
        openURL("https://github.com/meowbutlerdev")
    }

    func didTapBlog() {
        openURL("https://until.blog/@meowbutlerdev")
    }

    func didTapButton(at index: Int) {
        jiSungContainerView.handleButtonTap(at: index)
    }

    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
