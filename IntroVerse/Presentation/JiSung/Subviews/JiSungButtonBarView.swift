import UIKit
import SnapKit

final class JiSungButtonBarView: UIView {
    var onButtonTap: ((Int) -> Void)?

    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 31
        view.layer.masksToBounds = true
        view.alpha = 0.4
        return view
    }()

    private var buttons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        addSubview(backgroundView)
        addSubview(stackView)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }

        let buttonData = [
            ("🧑‍💻", "소개"),
            ("🤝", "협업 스타일"),
            ("🌟", "장점")
        ]

        for (index, (emoji, text)) in buttonData.enumerated() {
            let button = createButton(emoji: emoji, text: text)
            button.tag = index
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
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
        let attributedString = NSMutableAttributedString(string: "\(emoji)\n", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .regular)])
        attributedString.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
        return attributedString
    }

    @objc private func didTapButton(_ sender: UIButton) {
        onButtonTap?(sender.tag)
        setActiveButton(at: sender.tag)
    }

    func setActiveButton(at index: Int) {
        buttons.forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.white, for: .normal)
        }
        buttons[index].backgroundColor = .white
        buttons[index].setTitleColor(.black, for: .normal)
    }
}
