import UIKit
import SnapKit
import SafariServices

final class MinJaeViewController: UIViewController {
    private let mainCollectionView = MinjaeMainCollectionView()
    private var viewModel = MinJaeViewModel()
    
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
    }
    
    private func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.backgroundImageView.image = image
                    }
                }
            }
        }
    }
}

struct Constant {
    static var imageURL = "https://github.com/user-attachments/assets/7083f9cd-4418-4107-937e-e6c56659e255"
}
