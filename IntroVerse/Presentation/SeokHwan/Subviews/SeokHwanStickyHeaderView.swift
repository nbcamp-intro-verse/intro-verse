import UIKit
import SnapKit

final class SeokHwanStickyHeaderView: UIView {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "유석환"
        label.font = UIFont(name: "GmarketSansTTFBold", size: 32)
        label.textColor = .blue
        return label
    }()
    lazy var tmiLabel: UILabel = {
        let label = UILabel()
        label.text = "'s TMI"
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 24)
        return label
    }()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanStickyHeaderView {
    func configure() {
        configureLayout()
        configureConstraints()
    }

    func configureLayout() {
        addSubview(nameLabel)
        addSubview(tmiLabel)
    }

    func configureConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        tmiLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.trailing)
        }
    }
}
