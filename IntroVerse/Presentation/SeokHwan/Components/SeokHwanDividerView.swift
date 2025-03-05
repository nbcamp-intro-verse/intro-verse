import UIKit
import SnapKit

final class SeokHwanDivider: UIView {
    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanDivider {
    func configure() {
        backgroundColor = .lightGray
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
