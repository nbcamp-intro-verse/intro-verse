import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = MainViewModel()
    private let cache = NSCache<NSString, UIImage>()
    
    enum CarouselState {
        case idle
        case scrolling
        case autoScrolling
    }
    
    enum Constant {
        static let cellWidthRatio: CGFloat = 0.563
        static let cellHeightRatio: CGFloat = 0.45
        static let collectionViewCellSpace: CGFloat = 20
        static let autoScrollRepeatTime: DispatchTimeInterval = .milliseconds(10)
        static let initCollectionViewOffsetX: CGFloat = 100
        static let totalTimeToScrollPage: Float = 30.0
    }

    private var isAnimating = false
    lazy var cellWidth = CGFloat(Int(view.frame.width * Constant.cellWidthRatio))
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
        layout.minimumLineSpacing = Constant.collectionViewCellSpace
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.prefetchDataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCardCell.self, forCellWithReuseIdentifier: "CarouselCardCell")
        return collectionView
    }()
    
    private let blurBackgrounEffectView: UIVisualEffectView = {
         let visualEffectView = UIVisualEffectView()
         visualEffectView.effect = UIBlurEffect(style: .regular)
         return visualEffectView
     }()
     
     private let backgroundImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleToFill
         return imageView
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
        timer.schedule(deadline: .now(), repeating: Constant.autoScrollRepeatTime)
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
        // * Calculation *//
        let contentWidth = collectionView.contentSize.width
        let frameWidth = collectionView.frame.width
        // The total amount of time to scroll all contents when the total contents are * 3
        let totalTimeForWholeContents = CGFloat(Float(viewModel.cards.count) * Constant.totalTimeToScrollPage)
        let frameRate = CGFloat(60.0) // Frame Rate
        let autoScrollOffsetX = (contentWidth - frameWidth) / totalTimeForWholeContents / frameRate
        let offsetX = collectionView.contentOffset.x + autoScrollOffsetX
        collectionView.setContentOffset(CGPoint(x: offsetX, y: collectionView.contentOffset.y), animated: false)
    }
    
    private func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(blurBackgrounEffectView)
        view.addSubview(collectionView)
        view.addSubview(introView)
    }
    
    private func configureLayout() {
        let height = Int(view.frame.height * Constant.cellHeightRatio)
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        blurBackgrounEffectView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
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
    
    deinit {
        stopAutoScrollTimer()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 증가 시켜 놓고
        return viewModel.cards.count * 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 다시 index 계산
        let actualIndex = indexPath.row % viewModel.cards.count
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCardCell.identifier, for: indexPath) as? CarouselCardCell else { return UICollectionViewCell() }
        cell.configure(card: viewModel.cards[actualIndex])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidthIncludeSpace = cellWidth + Constant.collectionViewCellSpace
        let totalContentWidth = cellWidthIncludeSpace * CGFloat(viewModel.cards.count * 3)
        if collectionView.contentOffset.x < 0 {
            collectionView.contentOffset = CGPoint(x: totalContentWidth, y: collectionView.contentOffset.y)
        }
        let thresholdRatio = 0.9
        if collectionView.contentOffset.x > totalContentWidth * thresholdRatio {
            collectionView.contentOffset = CGPoint(x: 0, y: collectionView.contentOffset.y)
        }
        
        // rounding problem
        let actualIndex = Int(round(collectionView.contentOffset.x / cellWidthIncludeSpace)) % viewModel.cards.count
        updateBackgroundImage(for: actualIndex)
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        carouselState = .autoScrolling
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actualIndex = indexPath.row % viewModel.cards.count
        // 다시계산
        let viewController = viewModel.cards[actualIndex].memberViewController.initViewController()
        self.present(viewController, animated: true)
    }
    
    func updateBackgroundImage(for index: Int) {
        guard !isAnimating else { return }
        isAnimating = true
        DispatchQueue.main.async { [weak self] in
            if let imageName = self?.viewModel.cards[index].imageName {
                UIView.transition(with: self?.backgroundImageView ?? UIView(),
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self?.backgroundImageView.image = UIImage(named: imageName)},
                    completion: { _ in self?.isAnimating = false })
            } else {
                print("Failed to fetch image from view model")
                self?.isAnimating = false
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let actualIndex = indexPath.row % viewModel.cards.count
            let imageName = viewModel.cards[actualIndex].imageName
            if let cachedImage = cache.object(forKey: imageName as NSString) {
                continue
            }
            // else get data from network
        }
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

extension MainViewModel {
    var totalItemCounts: CGFloat {
        return CGFloat(cards.count * 3)
    }
}
