import UIKit
import SnapKit

final class SeokHwanDividerView: UIView {
    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanDividerView {
    func configure() {
        backgroundColor = .lightGray
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
