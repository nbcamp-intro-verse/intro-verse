import UIKit
import SnapKit

final class JiSungBlurBoxView: UIView {
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.9
        return view
    }()

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.0, 0.4, 1.0]
        return gradientLayer
    }()

    private let shapeLayer = CAShapeLayer()
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

        blurEffectView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurEffectView.frame = bounds
        gradientLayer.frame = bounds

        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        shapeLayer.path = path.cgPath

        blurEffectView.layer.mask = gradientLayer
        layer.mask = shapeLayer
    }
}
