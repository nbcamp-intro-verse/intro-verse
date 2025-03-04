import UIKit
import SnapKit

final class SeokHwanDividerView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeokHwanDividerView"
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

private extension SeokHwanDividerView {
    func configure() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
