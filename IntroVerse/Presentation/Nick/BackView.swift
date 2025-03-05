
import UIKit
final class BackView: UIView {
    private lazy var blurimgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .extraLight)
        let visualEffectView = UIVisualEffectView(effect: blur)
        return visualEffectView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .fira(size: 10, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blurimgView)
        blurimgView.addSubview(label)
        
        blurimgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(width image: UIImage, text: String) {
        blurimgView.image = image
        label.text = text
    }
}
