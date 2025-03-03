import UIKit

final class CarouselCardCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {

    }
}
