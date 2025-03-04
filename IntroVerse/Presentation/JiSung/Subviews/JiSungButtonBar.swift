import UIKit
import SnapKit

final class JiSungButtonBar: UIView {
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 31
        view.layer.masksToBounds = true
        view.alpha = 0.7
        return view
    }()

    private var buttons: [UIButton] = []
    
    var onButtonSelected: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        layer.cornerRadius = 31
        clipsToBounds = true

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        addSubview(backgroundView)
        addSubview(stackView)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }

        let buttonData = [
            ("🧑‍💻", "소개"),
            ("🤝", "협업 스타일"),
            ("🌟", "장점")
        ]

        for (index, (emoji, text)) in buttonData.enumerated() {
            let button = createButton(emoji: emoji, text: text)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    private func createButton(emoji: String, text: String) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(makeButtonTitle(emoji: emoji, text: text), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 31
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        return button
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

    @objc private func buttonTapped(_ sender: UIButton) {
        activateButton(at: sender.tag)
        onButtonSelected?(sender.tag)
    }

    func activateButton(at index: Int) {
        buttons.forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.white, for: .normal)
        }
        buttons[index].backgroundColor = .white
        buttons[index].setTitleColor(.black, for: .normal)
    }
}
