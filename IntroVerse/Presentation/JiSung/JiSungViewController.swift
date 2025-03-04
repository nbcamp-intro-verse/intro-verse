import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "jisung_profile")
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "박지성"
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let githubLabel: UILabel = {
        let label = UILabel()
        label.text = "https://github.com/meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    private let blogLabel: UILabel = {
        let label = UILabel()
        label.text = "https://until.blog/@meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    private let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.layer.cornerRadius = 31
        view.clipsToBounds = true

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)

        return view
    }()

    private let tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()

    private let aboutButton: UIButton = JiSungViewController.createTabButton()
    private let styleButton: UIButton = JiSungViewController.createTabButton()
    private let strengthsButton: UIButton = JiSungViewController.createTabButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtonTitles()
        setupInitialSelection()
    }

    private func setupLayout() {
        view.insertSubview(backgroundImageView, at: 0)
        view.addSubview(nameLabel)
        view.addSubview(githubLabel)
        view.addSubview(blogLabel)
        view.addSubview(buttonBackgroundView)
        view.addSubview(tabStackView)

        buttonBackgroundView.addSubview(tabStackView)
        tabStackView.addArrangedSubview(aboutButton)
        tabStackView.addArrangedSubview(styleButton)
        tabStackView.addArrangedSubview(strengthsButton)

        aboutButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        styleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        strengthsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.85)
        }

        githubLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        blogLabel.snp.makeConstraints { make in
            make.top.equalTo(githubLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        buttonBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(blogLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }

        tabStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupButtonTitles() {
        aboutButton.setAttributedTitle(makeButtonTitle(emoji: "🧑‍💻", text: "소개"), for: .normal)
        styleButton.setAttributedTitle(makeButtonTitle(emoji: "🤝", text: "협업 스타일"), for: .normal)
        strengthsButton.setAttributedTitle(makeButtonTitle(emoji: "🌟", text: "장점"), for: .normal)
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        activateButton(sender)
    }

    private func setupInitialSelection() {
        activateButton(aboutButton)
    }

    private func activateButton(_ button: UIButton) {
        [aboutButton, styleButton, strengthsButton].forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.white, for: .normal)
        }

        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
    }

    private func makeButtonTitle(emoji: String, text: String) -> NSAttributedString {
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .medium)
        ]

        let attributedString = NSMutableAttributedString(string: "\(emoji)\n", attributes: emojiAttributes)
        attributedString.append(NSAttributedString(string: text, attributes: textAttributes))

        return attributedString
    }

    private static func createTabButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 31
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        return button
    }
}
