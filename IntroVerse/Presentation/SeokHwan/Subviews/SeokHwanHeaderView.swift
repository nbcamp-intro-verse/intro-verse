import UIKit
import SnapKit

final class SeokHwanHeaderView: UIView {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "유석환"
        label.textColor = .seokHwanTitle
        label.font = UIFont(name: "GmarketSansTTFBold", size: 32)
        return label
    }()
    private lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "1997.01.15"
        label.textColor = .seokHwanSubtitle
        label.font = UIFont(name: "GmarketSansTTFLight", size: 16)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 마스터 6기 유석환입니다!"
        label.textColor = .seokHwanTitle
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 18)
        return label
    }()
    private lazy var githubLinkButton = SeokHwanLinkButton(.github)
    private lazy var blogLinkButton = SeokHwanLinkButton(.blog)

    weak var delegate: SeokHwanLinkButtonDelegate? {
        didSet {
            githubLinkButton.delegate = delegate
            blogLinkButton.delegate = delegate
        }
    }

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
        addSubview(nameLabel)
        addSubview(birthdayLabel)
        addSubview(descriptionLabel)
        addSubview(blogLinkButton)
        addSubview(githubLinkButton)
    }

    func configureConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        blogLinkButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        githubLinkButton.snp.makeConstraints { make in
            make.top.equalTo(blogLinkButton.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
    }
}
