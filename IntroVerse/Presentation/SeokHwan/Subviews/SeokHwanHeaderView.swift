import UIKit
import SnapKit

final class SeokHwanHeaderView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var koreanNameLabel: UILabel = {
        let label = UILabel()
        label.text = "유석환"
        return label
    }()
    private lazy var englishNameLabel: UILabel = {
        let label = UILabel()
        label.text = "youseokhwan"
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
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
        stackView.addArrangedSubview(englishNameLabel)
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
