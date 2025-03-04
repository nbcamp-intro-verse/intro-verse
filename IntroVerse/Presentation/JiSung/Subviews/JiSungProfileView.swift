import UIKit
import SnapKit

final class JiSungProfileView: UIView {
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
        label.textColor = .lightGray
        return label
    }()

    private let blogLabel: UILabel = {
        let label = UILabel()
        label.text = "https://until.blog/@meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, githubLabel, blogLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5

        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
