import UIKit
import SnapKit

final class SeokHwanTMIItem: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house.circle")
        return imageView
    }()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "textLabel"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanTMIItem {
    func configure() {
        configureLayout()
        configureConstraints()
    }

    func configureLayout() {
        addSubview(imageView)
        addSubview(textLabel)
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(60)
        }
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
}
