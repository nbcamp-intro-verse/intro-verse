import UIKit
import SnapKit

final class SeokHwanProfileImageView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeokHwanProfileImageView"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension SeokHwanProfileImageView {
    func configure() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
