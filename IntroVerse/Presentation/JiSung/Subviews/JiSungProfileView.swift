import UIKit
import SnapKit

protocol JiSungProfileViewDelegate: AnyObject {
    func didTapGitHub()
    func didTapBlog()
}

final class JiSungProfileView: UIView {
    weak var delegate: JiSungProfileViewDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "박지성"
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let githubLabel: UILabel = {
        let label = UILabel()
        label.text = "https://github.com/meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()

    private let blogLabel: UILabel = {
        let label = UILabel()
        label.text = "https://until.blog/@meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()

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
        let githubTap = UITapGestureRecognizer(target: self, action: #selector(didTapGitHub))
        githubLabel.addGestureRecognizer(githubTap)

        let blogTap = UITapGestureRecognizer(target: self, action: #selector(didTapBlog))
        blogLabel.addGestureRecognizer(blogTap)
    }

    @objc private func didTapGitHub() {
        delegate?.didTapGitHub()
    }

    @objc private func didTapBlog() {
        delegate?.didTapBlog()
    }
}
