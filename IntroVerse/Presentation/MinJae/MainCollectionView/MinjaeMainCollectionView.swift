import UIKit

protocol MinjaeMainCollectionViewDelegate: AnyObject {
    func linkButtonTapped(url: URL)
}

final class MinjaeMainCollectionView: UICollectionView {
    
    private let dividedContents: [ContentType] = [ .information, .motto, .introduce, .talk, .memo]
    weak var collectionViewDelegate: MinjaeMainCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame,
                   collectionViewLayout: MinjaeMainCollectionViewFlowLayout())
        backgroundColor = .white.withAlphaComponent(0)
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        register(MinjaeMainCollectionViewCell.self,
                 forCellWithReuseIdentifier: MinjaeMainCollectionViewCell.identifier)
        register(MinjaeMainCollectionHeaderView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: MinjaeMainCollectionHeaderView.identifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MinjaeMainCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dividedContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MinjaeMainCollectionViewCell.identifier, for: indexPath) as? MinjaeMainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(model: dividedContents[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MinjaeMainCollectionHeaderView.identifier, for: indexPath) as? MinjaeMainCollectionHeaderView else { return UICollectionReusableView() }
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = MinjaeMainCollectionViewCell(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width - 40, height: 400))
        cell.configure(model: dividedContents[indexPath.row])
        cell.layoutIfNeeded()
        let estiamtedSize = cell.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width - 40, height: 400))
        return CGSize(width: collectionView.frame.width - 40, height: estiamtedSize.height)
    }
    
}

extension MinjaeMainCollectionView: MinjaeCollectionHeaderViewDelegate {
    func linkButtonTapped(url: URL) {
        collectionViewDelegate?.linkButtonTapped(url: url)
    }
}

enum ContentType {
    case information
    case motto
    case introduce
    case talk
    case memo
    
    enum MinjaeContent: Int {
        case title
        case name
        case birth
        case mbti
        case description
        case memoButton
    }
    
    struct MinjaeDataModel {
        var title: String? = nil
        var name: String? = nil
        var birth: String? = nil
        var description: String? = nil
    }
    
    var inputContent: [MinjaeContent] {
        switch self {
        case .information:
            return [.name, .birth, .mbti]
        case .motto:
            return [.title, .description]
        case .introduce:
            return [.title, .description]
        case .talk:
            return [.title, .description]
        case .memo:
            return [.title, .memoButton]
        }
    }
    
    var content: MinjaeDataModel {
        switch self {
        case .information:
            return MinjaeDataModel(name: "이민재", birth: "1996.10.16")
        case .motto:
            return MinjaeDataModel(title: "좌우명", description: "🔥 JUST DO IT 🔥")
        case .introduce:
            return MinjaeDataModel(title: "저를 소개합니다", description: "저는 컴퓨터 공학과 전공이며, 인턴으로 유니티를 활용한 슈팅게임 개발을 한 적이 있습니다. 졸업 후 장기간 다른 일을 하다가 iOS 앱 개발이 하고싶어서 개발자가 되기 위해 노력하고 있습니다. UI/UX에 관심이 많아 UIKit의 주요 컴포넌트들을 공부하고 있습니다. 취미는 운동과 게임입니다.")
        case .talk:
            return MinjaeDataModel(title: "한마디", description: "지금까지 스파르타 캠프를 하면서 지식이 많이 부족함을 느끼고 있습니다. 부족한 만큼 적극적인 태도로 캠프에 참여하도록 하겠습니다!")
        case .memo:
            return MinjaeDataModel(title: "메모")
        }
    }
}


