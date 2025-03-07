import UIKit
import SnapKit

final class IntroView: UIView {
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 마스터 6기 4조"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center

        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "IntroVerse"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
        안녕하세요, iOS 마스터 6기 4조입니다.
        내일배움캠프에서 선보이는 첫 앱
        IntroVerse에 오신 것을 환영합니다!
        저희 팀의 이야기를 담은 이 앱을 통해 창의적인 개발 여정을 함께 하시길 바랍니다.
        """
        label.font = .preferredFont(forTextStyle: .body)

        return label
    }()

    private let githubButton: UIButton = {
        let resizedImage = UIImage(named: "gitHubIcon_white")?.resize(targetSize: CGSize(width: 20, height: 20))
        let button = UIButton(type: .custom)
        button.setTitle("GitHub", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        button.setImage(resizedImage, for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.contentHorizontalAlignment = .center


        return button

    }()

    private let notionButton: UIButton = {
        let resizedImage = UIImage(named: "notionIcon_white")?.resize(targetSize: CGSize(width: 20, height: 20))
        let button = UIButton(type: .custom)
        button.setImage(resizedImage, for: .normal)
        button.setTitle("Notion", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 8

        return button
    }()

    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        self.addSubview(topLabel)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(githubButton)
        self.addSubview(notionButton)
        
        githubButton.addTarget(self, action: #selector(githubButtonTapped), for: .touchUpInside)
        notionButton.addTarget(self, action: #selector(notionButtonTapped), for: .touchUpInside)

        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupConstraints() {
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        githubButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.trailing.equalTo(self.snp.centerX).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(32)
        }

        notionButton.snp.makeConstraints { make in
            make.centerY.equalTo(githubButton)
            make.leading.equalTo(self.snp.centerX).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(32)
        }
    }

    // MARK: - Actions
    @objc private func githubButtonTapped() {
        SeoYoungLinkPage.mainGithub.open()
    }

    @objc private func notionButtonTapped() {
        SeoYoungLinkPage.mainNotion.open()
    }
}
