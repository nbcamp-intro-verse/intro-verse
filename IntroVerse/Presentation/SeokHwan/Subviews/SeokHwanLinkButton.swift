import UIKit

typealias LinkButtonType = SeokHwanLinkButton.LinkButtonType

protocol SeokHwanLinkButtonDelegate: AnyObject {
    func didTapLinkButton(_ type: LinkButtonType)
}

final class SeokHwanLinkButton: UIButton {
    enum LinkButtonType: String {
        case blog = "Blog"
        case github = "GitHub"
        case none

        var imageName: String {
            switch self {
            case .blog:
                return "SeokHwanBlog"
            case .github:
                return "SeokHwanGitHub"
            default:
                return ""
            }
        }

        var urlString: String {
            switch self {
            case .blog:
                return "https://youseokhwan.me"
            case .github:
                return "https://github.com/youseokhwan"
            default:
                return ""
            }
        }
    }

    weak var delegate: SeokHwanLinkButtonDelegate?
    var linkButtonType: LinkButtonType = .none

    convenience init(_ linkButtonType: LinkButtonType) {
        self.init(type: .system)
        self.linkButtonType = linkButtonType
        configure()
    }

    @objc func didTapLinkButton(_ sender: SeokHwanLinkButton) {
        delegate?.didTapLinkButton(sender.linkButtonType)
    }
}

private extension SeokHwanLinkButton {
    func configure() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = linkButtonType.rawValue
        configuration.image = UIImage(named: linkButtonType.imageName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        configuration.baseForegroundColor = .black
        self.configuration = configuration

        backgroundColor = UIColor(red: 143 / 255, green: 202 / 255, blue: 202 / 255, alpha: 1)
        layer.cornerRadius = 10
        addTarget(self, action: #selector(didTapLinkButton(_:)), for: .touchUpInside)
    }
}
