import UIKit
import SnapKit

final class SeokHwanKeywordsView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeokHwanKeywordsView"
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

private extension SeokHwanKeywordsView {
    func configure() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
