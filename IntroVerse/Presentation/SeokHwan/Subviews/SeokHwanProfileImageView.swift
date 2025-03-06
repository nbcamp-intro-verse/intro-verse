import UIKit

final class SeokHwanProfileImageView: UIImageView {
    convenience init() {
        self.init(frame: .zero)
        configureLayout()
    }
}

private extension SeokHwanProfileImageView {
    func configureLayout() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 10
        image = UIImage(named: "SeokHwanProfile")
    }
}
