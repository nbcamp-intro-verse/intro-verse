import UIKit

final class MinjaeContentStackView: UIStackView {
    
    var memos: [String] = []
    private lazy var views: [UIView] = [titleLabel, nameLabel, birthLabel, mbtiStackView, descriptionLabel, memoTitleStackView, memoStackView]
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "타이틀"
        lb.textColor = .black.withAlphaComponent(0.8)
        return lb
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "이민재"
        return lb
    }()
    
    private let birthLabel: UILabel = {
        let lb = UILabel()
        lb.text = "birth"
        return lb
    }()
    
    private let mbtiStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 3
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        let leftBlankLabel = UILabel()
        let rightBlankLabel = UILabel()
        let mbtiLabel = UILabel()
        leftBlankLabel.text = " "
        rightBlankLabel.text = " "
        mbtiLabel.textColor = .white
        mbtiLabel.text = "ENFP"
        mbtiLabel.textAlignment = .center
        sv.backgroundColor = .blue.withAlphaComponent(0.5)
        sv.clipsToBounds = true
        sv.layer.cornerRadius = 10
        sv.addArrangedSubview(leftBlankLabel)
        sv.addArrangedSubview(mbtiLabel)
        sv.addArrangedSubview(rightBlankLabel)
        return sv
    }()
    
    private let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "설명"
        lb.numberOfLines = 0
        lb.textColor = .white
        return lb
    }()
    
    private lazy var memoTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        let titleLabel = UILabel()
        titleLabel.text = "메모"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        let addBtn = UIButton()
        addBtn.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold, scale: .large)), for: .normal)
        addBtn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(addBtn)
        return stackView
    }()
    
    private let memoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    @objc func addButtonTapped() {
        memos.
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = 1
        alignment = .leading
        distribution = .fill
        axis = .vertical
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func addSpecificViews(index: Int) {
        addArrangedSubview(views[index])
    }
    
    func configure(model: ContentType) {
        switch model {
        case .information:
            guard let name = model.content.name, let birth = model.content.birth else { return }
            nameLabel.text = name
            nameLabel.font = .boldSystemFont(ofSize: 45)
            birthLabel.text = birth
            birthLabel.font = .systemFont(ofSize: 15)
        case .motto:
            guard let title = model.content.title, let description = model.content.description else { return }
            titleLabel.text = title
            descriptionLabel.text = description
            descriptionLabel.font = .boldSystemFont(ofSize: 25)
            descriptionLabel.textAlignment = .center
            descriptionLabel.textColor = .black
        case .introduce:
            guard let title = model.content.title, let description = model.content.description else { return }
            titleLabel.font = .systemFont(ofSize: 15)
            descriptionLabel.font = .boldSystemFont(ofSize: 17)
            titleLabel.text = title
            descriptionLabel.text = description
        case .talk:
            guard let title = model.content.title, let description = model.content.description else { return }
            titleLabel.font = .systemFont(ofSize: 15)
            descriptionLabel.font = .boldSystemFont(ofSize: 17)
            titleLabel.text = title
            descriptionLabel.text = description
        case .memo:
            MinJaeViewModel.memos.forEach { memo in
                memoStackView.addArrangedSubview(setMemoLabel(text: memo))
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
