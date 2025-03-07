import UIKit

protocol MinjaeCollectionHeaderViewDelegate: AnyObject {
    func linkButtonTapped(url: URL)
}

final class MinjaeMainCollectionHeaderView: UICollectionReusableView {
    static let identifier = "MinjaeMainCollectionHeaderView"
    
    weak var delegate: MinjaeCollectionHeaderViewDelegate?
    private lazy var githubButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "GithubIcon"), for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(githubButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var notionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "NotionIcon"), for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(notionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(githubButton)
        addSubview(notionButton)
        configureLayout()
        backgroundColor = .white.withAlphaComponent(0)
    }
    
    @objc func githubButtonTapped() {
        delegate?.linkButtonTapped(url: URL(string: "https://github.com/minjae-L")!)
    }
    
    @objc func notionButtonTapped() {
        delegate?.linkButtonTapped(url: URL(string: "https://global-profit-946.notion.site/iOS-17feb1b45ca080cb9bb1ce6def7306b3")!)
    }
    
    private func configureLayout() {
        notionButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        githubButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(notionButton.snp.leading).offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
