import UIKit
import SnapKit

final class SeokHwanTMIItem: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house.circle")
        return imageView
    }()
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "textLabel"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 16)
        return label
    }()

    convenience init(imageName: String, text: String, isImagePositionRight: Bool = false) {
        self.init(frame: .zero)
        configure(imageName: imageName, text: text, isImagePositionRight: isImagePositionRight)
    }
}

private extension SeokHwanTMIItem {
    func configure(imageName: String, text: String, isImagePositionRight: Bool) {
        configureLayout()
        configureConstraints(isImagePositionRight: isImagePositionRight)
        configureAttributes(imageName: imageName, text: text)
    }

    func configureLayout() {
        addSubview(imageView)
        addSubview(textLabel)
    }

    func configureConstraints(isImagePositionRight: Bool) {
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        imageView.snp.makeConstraints { make in
            switch isImagePositionRight {
            case true:
                make.trailing.equalToSuperview().inset(10)
            case false:
                make.leading.equalToSuperview().inset(10)
            }
            make.width.height.equalTo(60)
        }
        textLabel.snp.makeConstraints { make in
            switch isImagePositionRight {
            case true:
                make.trailing.equalTo(imageView.snp.leading).offset(-20)
                make.leading.equalToSuperview()
            case false:
                make.leading.equalTo(imageView.snp.trailing).offset(20)
                make.trailing.equalToSuperview()
            }
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }

    func configureAttributes(imageName: String, text: String) {
        imageView.image = UIImage(named: imageName)
        textLabel.text = text
    }
}
