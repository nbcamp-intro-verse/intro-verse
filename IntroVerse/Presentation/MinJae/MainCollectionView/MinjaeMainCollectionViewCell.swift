import UIKit
import SnapKit

final class MinjaeMainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MinjaeMainCollectionViewCell"
    
    private let contentStackView = MinjaeContentStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white.withAlphaComponent(0.6)
        contentView.layer.cornerRadius = 15
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContentType) {
        contentStackView.configure(model: model)
        model.inputContent.forEach { element in
            contentStackView.addSpecificViews(index: element.rawValue)
        }
        
    }
    
}

