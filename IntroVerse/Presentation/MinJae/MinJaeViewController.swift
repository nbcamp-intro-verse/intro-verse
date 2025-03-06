import UIKit
import SnapKit
import Combine
import SafariServices

final class MinJaeViewController: UIViewController {
    private let mainCollectionView = MinjaeMainCollectionView()
    private var viewModel = MinJaeViewModel()
    private let imageRepository: ImageRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private func addViews() {
        view.addSubview(mainCollectionView)
    }
    
    private func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.collectionViewDelegate = self
        view.addSubview(backgroundImageView)
        loadImage(url: URL(string: Constant.imageURL)!)
        addViews()
        configureLayout()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("addAlert"),
                                               object: nil,
                                               queue: nil) { _ in
            let alertController = UIAlertController(title: "메모 추가", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "입력"
            }
            let okAction = UIAlertAction(title: "추가",
                                         style: .default) { [weak self] done in
                guard let text = alertController.textFields?[0].text else { return }
                MinJaeViewModel.memos.append(text)
                self?.mainCollectionView.reloadItems(at: [IndexPath(item: 4, section: 0)])
            }
            let cancelAction = UIAlertAction(title: "취소",
                                             style: .cancel)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    private func loadImage(url: URL) {
        imageRepository.loadImageNetwork(from: url, cahceOption: .memory)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Failed to load image: \(error)")
                }
            } receiveValue: { [weak self] image in
                self?.backgroundImageView.image = image
                self?.mainCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension MinJaeViewController: MinjaeMainCollectionViewDelegate {
    func linkButtonTapped(url: URL) {
        DispatchQueue.main.async { [weak self] in
            let safariView = SFSafariViewController(url: url)
            self?.present(safariView, animated: true)
        }
    }
}

struct Constant {
    static var imageURL = "https://github.com/user-attachments/assets/7083f9cd-4418-4107-937e-e6c56659e255"
}
