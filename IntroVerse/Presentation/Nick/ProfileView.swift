import UIKit

final class ProfileView: UIView {
    var topMargin: CGFloat = 20 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .fira(size: 20, weight: .semibold)
        label.text = "Seungho Jang"
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .fira(size: 14, weight: .medium)
        label.text = "\u{2022} Graphics Engineer"
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "nick_profile")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var githublogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "github_logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " : https://github.com/sjang1594"
        label.textColor = .white
        label.font = .fira(size: 18, weight: .semibold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var blogLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "nick_blog_logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " : https://sjang1594.github.io/"
        label.textColor = .white
        label.font = .fira(size: 18, weight: .semibold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(roleLabel)
        addSubview(imageView)
        addSubview(githublogoImageView)
        addSubview(githubLabel)
        addSubview(blogLogoImageView)
        addSubview(blogLabel)
        setViewConstraints()
    }
    
    private func setViewConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topMargin)
            make.leading.equalToSuperview().offset(10)
        }
                
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
            
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topMargin)
            make.trailing.equalToSuperview().offset(380)
            make.width.height.equalTo(72)
        }
                
        githublogoImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(bounds.width * 0.25)
            make.width.height.equalTo(32)
        }
                
        githubLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(7)
            make.leading.equalTo(githublogoImageView.snp.trailing).offset(10)
        }
                
        blogLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(githublogoImageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(bounds.width * 0.25)
            make.width.height.equalTo(32)
        }
                
        blogLabel.snp.makeConstraints { make in
            make.top.equalTo(githubLabel.snp.bottom).offset(14)
            make.leading.equalTo(blogLogoImageView.snp.trailing).offset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderWidth = 2
        githublogoImageView.layer.cornerRadius = githublogoImageView.frame.size.width / 2
        blogLogoImageView.layer.cornerRadius = blogLogoImageView.frame.size.width / 2
    }
}
