import UIKit
import SnapKit

final class JiSungBlurBoxView: UIView {
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.9
        return view
    }()

    private let maskLayer = CAShapeLayer()
    private let cornerRadius: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(blurEffectView)

        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        maskLayer.frame = bounds
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        maskLayer.path = path.cgPath
        blurEffectView.layer.mask = maskLayer
    }
}
