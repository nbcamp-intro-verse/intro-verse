import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let jiSungContainerView = JiSungContainerView()
    private let viewModel = JiSungViewModel()

    override func loadView() {
        view = jiSungContainerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        jiSungContainerView.onGitHubTap = { [weak self] in
            self?.viewModel.openGitHub()
        }
        jiSungContainerView.onBlogTap = { [weak self] in
            self?.viewModel.openBlog()
        }
        jiSungContainerView.onButtonTap = { [weak self] index in
            self?.jiSungContainerView.updateContent(at: index)
        }
    }
}
