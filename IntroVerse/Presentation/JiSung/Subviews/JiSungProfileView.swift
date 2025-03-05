import UIKit
import SnapKit

final class JiSungProfileView: UIView {
    var onGitHubTap: (() -> Void)?
    var onBlogTap: (() -> Void)?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "박지성"
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let githubLabel = JiSungProfileView.makeInteractiveLabel("https://github.com/meowbutlerdev")
    private let blogLabel = JiSungProfileView.makeInteractiveLabel("https://until.blog/@meowbutlerdev")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupGestureRecognizers()
    }

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, githubLabel, blogLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func setupGestureRecognizers() {
        githubLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGitHub)))
        blogLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBlog)))
    }

    @objc private func didTapGitHub() { onGitHubTap?() }
    @objc private func didTapBlog() { onBlogTap?() }

    private static func makeInteractiveLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }
}
