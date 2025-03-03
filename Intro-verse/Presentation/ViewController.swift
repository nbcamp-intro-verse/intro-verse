//
//  ViewController.swift (Main View)

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Property
    private var cards: [Card] = []
    private var activateCard: Card?
    
    // _ as indicator for private (can be excluded)
    // collection view
    // reason why I chose: collection view
    // * https://www.reddit.com/r/swift/comments/4gh5ta/question_help_should_i_use_collection_view_or/
    // * https://stackoverflow.com/questions/23078847/when-to-use-uicollectionview-instead-of-uitableview
    // More Customizable, both are inherited from UIScrollView
    private lazy var collectionView_: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCardCell.self, forCellWithReuseIdentifier: "CarouselCardCell")
        return collectionView
    }()
    
    private lazy var backgroundImgView_: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    // To set the blur view
    // https://zeddios.tistory.com/1140
    private lazy var blurView_: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    init(){
        // Maybe setup view model?
        super.init(nibName: nil, bundle: nil)
    }
    
    // Incase, init(frame: ) is called
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(backgroundImgView_)
        view.addSubview(blurView_)
        view.addSubview(collectionView_)
        
        // Constraints
        NSLayoutConstraint.activate([
            backgroundImgView_.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImgView_.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImgView_.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImgView_.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            blurView_.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blurView_.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            blurView_.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            blurView_.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView_.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView_.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView_.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView_.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
        
    }
    
    // MARK: - Bind View Model
    private func bindViewModel() {
    }
    
    // MARK: - Update UI View
    private func updateUIView(width card: Card?) {
    }
    
    // COMMENT: Not Decided Yet
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

#if DEBUG && os(iOS)
import SwiftUI
struct Preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
#endif
