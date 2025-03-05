import UIKit

final class FlippableCardView: UIView {
    private lazy var frontContentView: FrontView = {
        let view = FrontView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backContentView: BackView = {
        let view = BackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let animationDuration: TimeInterval = 0.3
    private var isFront = true
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(frontContentView)
        addSubview(backContentView)
        
        frontContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(260.78)
        }
            
        backContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(260.78)
        }
        
    }
    
    public func flipCard() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self,
                          duration: animationDuration,
                          options: transitionOptions,
                          animations: {
            self.frontContentView.isHidden.toggle()
            self.backContentView.isHidden.toggle()
        }) { _ in
            self.isFront.toggle()
        }
    }
    
    public func configure(with image: UIImage, frontText: String, backText: String) {
        frontContentView.configure(width: image, text: frontText)
        backContentView.configure(width: image, text: backText)
    }
}
