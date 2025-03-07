import UIKit

final class CarouselCardCell: UICollectionViewCell {
    
    static let identifier = "CarouselCardCell"
    
    // MARK: - Properties
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "jisung_profile"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private var positionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.4)
        return stackView
    }()
    
    private let positionIconLabel: UILabel = {
        let label = UILabel()
        label.text = "👑"
        return label
    }()
    
    private let positionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "리더"
        label.textColor = .white
        return label
    }()
    
    private let memberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private let memberTextLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "이민재"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let memberBirthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "1996.10.16"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        setupView()
        configureLayout()
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods
    private func setupView() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(positionStackView)
        contentView.addSubview(memberStackView)
    }
    
    private func setupStackView() {
        positionStackView.addArrangedSubview(UILabel())
        positionStackView.addArrangedSubview(positionIconLabel)
        positionStackView.addArrangedSubview(positionTextLabel)
        positionStackView.addArrangedSubview(UILabel())
        memberStackView.addArrangedSubview(UILabel())
        memberStackView.addArrangedSubview(memberTextLabel)
        memberStackView.addArrangedSubview(memberBirthLabel)
        
    }
    
    private func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        positionStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
        memberStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(contentView.frame.height / 4)
        }
    }

    func configure(card: Card) {
        backgroundImageView.image = UIImage(named: card.imageName)
        positionIconLabel.text = card.memberType.rawValue
        positionTextLabel.text = ""
        memberTextLabel.text = card.name
        memberBirthLabel.text = card.birthday
    }
}

