import UIKit
import SnapKit

final class SeoYoungViewController: UIViewController, UITextViewDelegate {
    private var viewModel = SeoYoungViewModel()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "한서영"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private var informationLabel: UILabel = {
        let label = UILabel()
        label.text = "2000.05.12\nISTP"
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor(red: 0.604, green: 0.651, blue: 0.698, alpha: 1)
        label.isMultipleTouchEnabled = true
        label.numberOfLines = 2
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sy_profile"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let githubImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "GithubIIcon_blue"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let linkedInImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LinkedInIcon_blue"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let tImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TIcon_blue"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [githubImageView, tImageView, linkedInImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var dividerView: UIView {
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.737, green: 0.8, blue: 0.863, alpha: 1)
        return divider
    }

    private let myAdvantagesCardView = CardView(
        title: "나의 장점",
        body: """
                다양한 apple 생태계를 경험해 보았습니다. \
                VisionOS, MacOS, iOS 그리고 watchOS 까지! \
                이런 배경지식을 바탕으로 앞으로도 다양한 프로젝트를 해보고 싶어요 
                """
    )

    private let myCooperationCardView = CardView(
        title: "내가 좋아하는 것",
        body: """
           같이 많은걸 해보는 협업을 선호합니다!
           개발뿐만 아니고 다양한 활동을 같이 
           하면서 협업의 방향성을 맞춰나가보아요.
           """
    )

    private let myAppsLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 앱들"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        return label
    }()

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 0, left: 41, bottom: 0, right: 41)
        return view
    }()

    private let labDuckIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon_LabDuck"))
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    private let pullUpperIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon_PullUpper"))
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 28
        imageView.layer.masksToBounds = true

        return imageView
    }()

    private let stepsIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon_Steps"))
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 28
        imageView.layer.masksToBounds = true

        return imageView
    }()

    private lazy var appIconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labDuckIconImageView, pullUpperIconImageView, stepsIconImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        return label
    }()

    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.backgroundColor = UIColor(red: 0.851, green: 0.918, blue: 0.992, alpha: 1).cgColor
        textView.layer.cornerRadius = 20
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let divider1 = dividerView
        let divider2 = dividerView
        let divider3 = dividerView

        view.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(informationLabel)
        view.addSubview(iconStackView)
        view.addSubview(divider1)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.left.equalToSuperview().inset(50)
            make.height.width.equalTo(125)
        }

        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        iconStackView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(6)
            make.left.equalTo(profileImageView.snp.right).offset(35)
        }

        [githubImageView, linkedInImageView, tImageView].forEach { imageView in
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(40)
            }
        }

        divider1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(41)
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(32)
            make.left.right.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        contentView.addSubview(myAdvantagesCardView)
        contentView.addSubview(myCooperationCardView)
        contentView.addSubview(divider2)
        contentView.addSubview(myAppsLabel)
        contentView.addSubview(appIconStackView)
        contentView.addSubview(divider3)
        contentView.addSubview(memoLabel)
        contentView.addSubview(memoTextView)

        myAdvantagesCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
        }

        myCooperationCardView.snp.makeConstraints { make in
            make.top.equalTo(myAdvantagesCardView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
        }

        divider2.snp.makeConstraints { make in
            make.top.equalTo(myCooperationCardView.snp.bottom).offset(32)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
            make.height.equalTo(1)
        }

        myAppsLabel.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(32)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
        }

        [labDuckIconImageView, pullUpperIconImageView, stepsIconImageView].forEach { imageView in
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(100)
            }
        }

        appIconStackView.snp.makeConstraints { make in
            make.top.equalTo(myAppsLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentView.layoutMarginsGuide)

        }

        divider3.snp.makeConstraints { make in
            make.top.equalTo(appIconStackView.snp.bottom).offset(32)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
            make.height.equalTo(1)
        }

        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(divider3).offset(32)
            make.left.right.equalTo(contentView.layoutMarginsGuide)
        }

        memoTextView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView.layoutMarginsGuide)
            make.height.equalTo(169)
            make.top.equalTo(memoLabel.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-32)
        }

        if let savedMemo = UserDefaults.standard.string(forKey: "memoText") {
            memoTextView.text = savedMemo
        }

        memoTextView.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(saveMemo), name: UIApplication.willResignActiveNotification, object: nil)

        addTapGestureRecognizers()
    }

    func textViewDidChange(_ textView: UITextView) {
        saveMemo()
    }

    @objc private func saveMemo() {
        let memo = memoTextView.text ?? ""
        UserDefaults.standard.set(memo, forKey: "memoText")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func addTapGestureRecognizers() {
        let gitHubTap = AppPageTapGestureRecognizer(page: .gitHub, target: self, action: #selector(handleIconTap(_:)))
        githubImageView.addGestureRecognizer(gitHubTap)

        let tistoryTap = AppPageTapGestureRecognizer(page: .tistory, target: self, action: #selector(handleIconTap(_:)))
        tImageView.addGestureRecognizer(tistoryTap)

        let linkedInTap = AppPageTapGestureRecognizer(page: .linkedIn, target: self, action: #selector(handleIconTap(_:)))
        linkedInImageView.addGestureRecognizer(linkedInTap)

        let labDuckTap = AppPageTapGestureRecognizer(page: .labDuck, target: self, action: #selector(handleIconTap(_:)))
        labDuckIconImageView.addGestureRecognizer(labDuckTap)

        let pullUpperTap = AppPageTapGestureRecognizer(page: .pullUpper, target: self, action: #selector(handleIconTap(_:)))
        pullUpperIconImageView.addGestureRecognizer(pullUpperTap)

        let stepsTap = AppPageTapGestureRecognizer(page: .steps, target: self, action: #selector(handleIconTap(_:)))
        stepsIconImageView.addGestureRecognizer(stepsTap)

        githubImageView.isUserInteractionEnabled = true
        tImageView.isUserInteractionEnabled = true
        linkedInImageView.isUserInteractionEnabled = true
        labDuckIconImageView.isUserInteractionEnabled = true
        pullUpperIconImageView.isUserInteractionEnabled = true
        stepsIconImageView.isUserInteractionEnabled = true
    }

    @objc private func handleIconTap(_ sender: AppPageTapGestureRecognizer) {
        sender.page.open()
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue

        let offset = keyboardFrame.height / 2
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -offset
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
