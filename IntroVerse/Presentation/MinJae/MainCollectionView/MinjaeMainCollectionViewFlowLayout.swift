import UIKit

final class MinjaeMainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        super.init()
    }
    
    private var alphaNum = 1.0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach({ attributes in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                var height = attributes.frame.height - contentOffsetY
                height < 60 ? height = 60 : nil
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: collectionView.frame.width, height: height)
            }
        })
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
