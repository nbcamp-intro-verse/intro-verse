import UIKit
import SnapKit
import SafariServices

final class MinJaeViewController: UIViewController {
    private let mainCollectionView = MinjaeMainCollectionView()
    private var viewModel = MinJaeViewModel()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "minjaeProfile")
        return imageView
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
}

extension MinJaeViewController: MinjaeMainCollectionViewDelegate {
    func linkButtonTapped(url: URL) {
        DispatchQueue.main.async { [weak self] in
            let safariView = SFSafariViewController(url: url)
            self?.present(safariView, animated: true)
        }
    }
}
