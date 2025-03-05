import UIKit

final class JiSungBackgroundView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentMode = .scaleAspectFill
        image = UIImage(named: "jisung_profile")
        clipsToBounds = true
    }
}
