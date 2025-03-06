import UIKit

typealias LinkButtonType = SeokHwanLinkButton.LinkButtonType

protocol SeokHwanLinkButtonDelegate: AnyObject {
    func didTapLinkButton(_ type: LinkButtonType)
}

final class SeokHwanLinkButton: UIButton {
    enum LinkButtonType: String {
        case blog = "블로그"
        case github = "깃허브"
        case none

        var imageName: String {
            switch self {
            case .blog:
                return "SeokHwanBlogLogo"
            case .github:
                return "SeokHwanGitHubLogo"
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
        var titleContainer = AttributeContainer()
        var subtitleContainer = AttributeContainer()
        var configuration = UIButton.Configuration.plain()

        titleContainer.font = UIFont(name: "GmarketSansTTFMedium", size: 14)
        subtitleContainer.font = UIFont(name: "GmarketSansTTFMedium", size: 12)
        configuration.attributedTitle = AttributedString(linkButtonType.rawValue,
                                                         attributes: titleContainer)
        configuration.attributedSubtitle = AttributedString(linkButtonType.urlString,
                                                            attributes: subtitleContainer)
        configuration.image = UIImage(named: linkButtonType.imageName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        configuration.baseForegroundColor = .seokHwanTitle

        self.configuration = configuration
        backgroundColor = .seokHwanLinkButtonBackground
        layer.cornerRadius = 10
        addTarget(self, action: #selector(didTapLinkButton(_:)), for: .touchUpInside)
    }
}
