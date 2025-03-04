import UIKit

final class SeokHwanProfileImageView: UIImageView {
    convenience init() {
        self.init(frame: .zero)
        configureLayout()
    }
}

private extension SeokHwanProfileImageView {
    func configureLayout() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 10
        tintColor = .systemGreen
        image = UIImage(systemName: "square.and.arrow.up")
    }
}
