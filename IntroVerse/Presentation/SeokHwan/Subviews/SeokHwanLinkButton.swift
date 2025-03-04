import UIKit

final class SeokHwanLinkButton: UIButton {
    enum ButtonType: String {
        case github = "GitHub"
        case blog = "Blog"

        var imageName: String {
            switch self {
            case .github:
                return "figure.tennis"
            case .blog:
                return "figure.tennis"
            }
        }

        var urlString: String {
            switch self {
            case .github:
                return "https://github.com/youseokhwan"
            case .blog:
                return "https://youseokhwan.me"
            }
        }
    }

    convenience init(_ type: SeokHwanLinkButton.ButtonType) {
        self.init(type: .system)
        configure(by: type)
    }
}

private extension SeokHwanLinkButton {
    func configure(by type: SeokHwanLinkButton.ButtonType) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = type.rawValue
        configuration.image = UIImage(systemName: type.imageName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.baseForegroundColor = .black
        self.configuration = configuration

        backgroundColor = UIColor(red: 143 / 255, green: 202 / 255, blue: 202 / 255, alpha: 1)
        layer.cornerRadius = 10
    }
}
