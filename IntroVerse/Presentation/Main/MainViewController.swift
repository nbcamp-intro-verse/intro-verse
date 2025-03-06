import UIKit
import SnapKit

enum CarouselState {
    case idle
    case scrolling
    case autoScrolling
}

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = MainViewModel()
    let collectionCache = NSCache<NSString, UIColor>()

    
    lazy var cellWidth = CGFloat(Int(view.frame.width * 0.563))
    private var carouselState: CarouselState = .idle {
        didSet{
            switch carouselState {
            case .autoScrolling:
                startAutoScrollTimer()
            case .idle, .scrolling:
                stopAutoScrollTimer()
            }
        }
    }
    
    private var autoScrollTimer: DispatchSourceTimer?

    private lazy var collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.prefetchDataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCardCell.self, forCellWithReuseIdentifier: "CarouselCardCell")
        return collectionView
    }()
    
    private let introView = IntroView()
    
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
        view.backgroundColor = .white
        addViews()
        configureLayout()
        carouselState = .autoScrolling
    }
    
    private func startAutoScrollTimer() {
        stopAutoScrollTimer()
        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now(), repeating: .milliseconds(10))
        timer.setEventHandler { [weak self] in
            self?.autoScroll()
        }
        timer.resume()
        autoScrollTimer = timer
    }

    private func stopAutoScrollTimer() {
        autoScrollTimer?.cancel()
        autoScrollTimer = nil
    }
    
    // MARK: - Methods
    private func autoScroll() {
        guard carouselState == .autoScrolling else { return }
        let offsetX = collectionView.contentOffset.x + 0.5
        collectionView.setContentOffset(CGPoint(x: offsetX, y: collectionView.contentOffset.y), animated: false)
    }
    
    private func addViews() {
        view.addSubview(collectionView)
        view.addSubview(introView)
    }
    
    private func configureLayout() {
        let height = Int(view.frame.height * 0.45)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        introView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialOffset = CGPoint(x: cellWidth + 100, y: collectionView.contentOffset.y)
        collectionView.setContentOffset(initialOffset, animated: false)
    }
    
    deinit {
        stopAutoScrollTimer()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.cards.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCardCell.identifier, for: indexPath) as? CarouselCardCell else { return UICollectionViewCell() }
        cell.configure(card: viewModel.cards[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let widthIncludeSpace = cellWidth + 20
        let cardCount: Double = Double(dummyColors.count - 2)
        if scrollView.contentOffset.x < 0 {
            scrollView.contentOffset = CGPoint(x: widthIncludeSpace * cardCount, y: scrollView.contentOffset.y)
        }
        if scrollView.contentOffset.x > widthIncludeSpace * cardCount {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.frame.height - 10)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        carouselState = .scrolling
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        carouselState = .autoScrolling
    }
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // cache
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // delete cache
    }
}

class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width * 0.5
        
        attributes.forEach { attribute in
            let distance = attribute.center.x - centerX
            let angle = distance / (UIScreen.main.bounds.height * 4)
            let scale = max((1 - abs(distance / collectionView.bounds.width * 0.5)), 0.8)
            attribute.transform = CGAffineTransform(translationX: 0, y: 0)
                .rotated(by: angle)
                .scaledBy(x: scale, y: scale)
            attribute.zIndex = Int(1000 - abs(centerX))
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            return true
    }
}
