import UIKit
import SnapKit

final class JiSungContentView: UIView {
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 31
        view.layer.masksToBounds = true
        view.alpha = 0.7
        return view
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(contentLabel)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(20)
        }
    }

    func upDateContent(text: String) {
        contentLabel.text = text
    }
}
