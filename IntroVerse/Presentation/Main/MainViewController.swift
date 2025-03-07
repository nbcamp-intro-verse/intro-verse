import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = MainViewModel()
    let collectionCache = NSCache<NSString, UIColor>()
    private var currentOffset: CGPoint = CGPoint(x: 0, y: 0)
    private var currentMemberImageIndex = 3
    private var needToUpdateBackgroundImage: Bool = false
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
        static let autoScrollOffsetX: CGFloat = 0.5
        static let initCollectionViewOffsetX: CGFloat = 100
    }
    
    let images = [UIImage(named: "minjaeProfile"),
                  UIImage(named: "jisung_profile"),
                  UIImage(named: "nick_profile"),
                  UIImage(named: "sy_profile"),
                  UIImage(named: "SeokHwanProfile"),
                  UIImage(named: "minjaeProfile"),
                  UIImage(named: "jisung_profile")]
    
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
        let offsetX = collectionView.contentOffset.x + Constant.autoScrollOffsetX
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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        introView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        blurBackgrounEffectView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    
    func updateBackgroundImage(for index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundImageView.image = self?.images[index]
        }
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
        let cellWidthIncludeSpace = cellWidth + 20
        let infiniteCarouselCount = viewModel.infiniteCarouselCount
        
        if scrollView.contentOffset.x < 0 {
            scrollView.contentOffset = CGPoint(x: cellWidthIncludeSpace * infiniteCarouselCount, y: scrollView.contentOffset.y)
        }
        if scrollView.contentOffset.x > cellWidthIncludeSpace * infiniteCarouselCount {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        }
        let centerPoint = CGPoint(x: scrollView.bounds.midX + scrollView.contentOffset.x, y: scrollView.bounds.midY)
        
        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            updateBackgroundImage(for: indexPath.row)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = viewModel.cards[indexPath.row].memberViewController.initViewController()
        self.present(viewController, animated: true)
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
            let scale = max((1 - abs(distance / collectionView.bounds.width * 0.5)), 0.9)
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

