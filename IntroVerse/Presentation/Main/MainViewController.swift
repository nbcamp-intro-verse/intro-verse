import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var cards: [Card] = []
    private var activateCard: Card?
    let cache: ImageCache
    let imageRepository: ImageRepository
    
    /** Dummy UI Components */
    lazy var jiSungButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("JiSung", for: .normal)
        button.addTarget(self, action: #selector(jiSungAction), for: .touchUpInside)
        return button
    }()
    lazy var minJaeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("MinJae", for: .normal)
        button.addTarget(self, action: #selector(minJaeAction), for: .touchUpInside)
        return button
    }()
    lazy var nickButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nick", for: .normal)
        button.addTarget(self, action: #selector(nickAction), for: .touchUpInside)
        return button
    }()
    lazy var seokHwanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SeokHwan", for: .normal)
        button.addTarget(self, action: #selector(seokHwanAction), for: .touchUpInside)
        return button
    }()
    lazy var seoYoungButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SeoYoung", for: .normal)
        button.addTarget(self, action: #selector(seoYoungAction), for: .touchUpInside)
        return button
    }()

    /**
     Dummy Button Actions
     */
    @objc func jiSungAction() {
        let viewController = JiSungViewController()
        viewController.modalPresentationStyle = .automatic
        present(viewController, animated: true)
    }
    @objc func minJaeAction() {
        let viewController = MinJaeViewController(imageRepository: imageRepository)
        viewController.modalPresentationStyle = .automatic
        present(viewController, animated: true)
    }
    @objc func nickAction() {
        let viewController = NickViewController()
        viewController.modalPresentationStyle = .automatic
        present(viewController, animated: true)
    }
    @objc func seokHwanAction() {
        let viewController = SeokHwanViewController()
        viewController.modalPresentationStyle = .automatic
        present(viewController, animated: true)
    }
    @objc func seoYoungAction() {
        let viewController = SeoYoungViewController()
        viewController.modalPresentationStyle = .automatic
        present(viewController, animated: true)
    }

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
        self.cache = ImageCache()
        self.imageRepository = ImageRepository(cache: cache)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.cache = ImageCache()
        self.imageRepository = ImageRepository(cache: cache)
        super.init(coder: coder)
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
        dummySetupView()
    }

    // MARK: - Methods
    /**
     Dummy Methods
     */
    private func dummySetupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(jiSungButton)
        view.addSubview(minJaeButton)
        view.addSubview(nickButton)
        view.addSubview(seokHwanButton)
        view.addSubview(seoYoungButton)
        jiSungButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        minJaeButton.snp.makeConstraints { make in
            make.top.equalTo(jiSungButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        nickButton.snp.makeConstraints { make in
            make.top.equalTo(minJaeButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        seokHwanButton.snp.makeConstraints { make in
            make.top.equalTo(nickButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        seoYoungButton.snp.makeConstraints { make in
            make.top.equalTo(seokHwanButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
    }

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

    private func updateUIView(with card: Card?) {

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
