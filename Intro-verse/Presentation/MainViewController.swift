import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var cards: [Card] = []
    private var activateCard: Card?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCardCell.self, forCellWithReuseIdentifier: "CarouselCardCell")
        return collectionView
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Methods
    private func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(blurView)
        view.addSubview(collectionView)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.45)
        }
    }

    private func bindViewModel() {

    }

    private func updateUIView(width card: Card?) {

    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
