import UIKit

final class CarouselCardCell: UICollectionViewCell {
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods
    private func setupView() {

    }
}
