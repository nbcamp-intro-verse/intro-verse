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
                return "figure.golf"
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
        self.configuration = configuration
    }
}
