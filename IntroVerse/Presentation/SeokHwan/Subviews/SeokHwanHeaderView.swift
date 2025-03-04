import UIKit
import SnapKit

final class SeokHwanHeaderView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var koreanNameLabel: UILabel = {
        let label = UILabel()
        label.text = "유석환"
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    private lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "1997.01.15"
        label.textColor = .systemGray
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 마스터 6기 유석환입니다! 잘부탁드립니다~"
        label.numberOfLines = 0
        return label
    }()
    private lazy var githubLinkButton = SeokHwanLinkButton(.github)
    private lazy var blogLinkButton = SeokHwanLinkButton(.blog)

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanHeaderView {
    func configure() {
        configureLayout()
        configureConstraints()
    }

    func configureLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(koreanNameLabel)
        stackView.addArrangedSubview(birthdayLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(githubLinkButton)
        stackView.addArrangedSubview(blogLinkButton)
    }

    func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
