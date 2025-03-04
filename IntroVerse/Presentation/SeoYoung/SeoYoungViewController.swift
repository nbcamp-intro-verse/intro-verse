import UIKit
import SnapKit

final class SeoYoungViewController: UIViewController {
    private var viewModel = SeoYoungViewModel()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "한서영"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)

        return label
    }()

    private var informationLabel: UILabel = {
        let label = UILabel()
        label.text = "2000.05.12\nISTP"
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor(red: 0.604, green: 0.651, blue: 0.698, alpha: 1)
        label.isMultipleTouchEnabled = true
        label.numberOfLines = 2

        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sy_profile"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let githubImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "GithubIIcon_blue"))
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    private let linkedInImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LinkedInIcon_blue"))
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    private let tImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TIcon_blue"))
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [githubImageView, tImageView, linkedInImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var dividerView: UIView = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.737, green: 0.8, blue: 0.863, alpha: 1)

        return label
    } ()

    private let myAdvantagesCardView = CardView(
        title: "나의 장점",
        body: """
                다양한 apple 생태계를 경험해 보았습니다. \
                VisionOS, MacOS, iOS 그리고 watchOS 까지! \
                이런 배경지식을 바탕으로 앞으로도 다양한 프로젝트를 해보고 싶어요
                """
    )

    private let myCooperationCardView = CardView(
        title: "내가 좋아하는 것",
        body: """
           같이 많은걸 해보는 협업을 선호합니다!
           개발뿐만 아니고 다양한 활동을 같이 
           하면서 협업의 방향성을 맞춰나가보아요.
           """
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(informationLabel)
        view.addSubview(iconStackView)
        view.addSubview(dividerView)
        view.addSubview(myAdvantagesCardView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.left.equalToSuperview().inset(50)
            make.height.width.equalTo(125)
        }

        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        iconStackView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(6)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        [githubImageView, linkedInImageView, tImageView].forEach { imageView in
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(40)
            }
        }

        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(41)
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
        }

        myAdvantagesCardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(41)
            make.top.equalTo(dividerView.snp.bottom).offset(32)
        }

    }
}
