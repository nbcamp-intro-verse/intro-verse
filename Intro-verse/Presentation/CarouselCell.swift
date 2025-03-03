import Foundation
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
        fatalError()
    }

    private func setupView() {

    }
}
