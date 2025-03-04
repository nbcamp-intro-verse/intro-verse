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
        layer.borderWidth = 1
        layer.cornerRadius = 10
        tintColor = .systemGray
        image = UIImage(systemName: "person.circle")
    }
}
