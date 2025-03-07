import UIKit

enum MemberViewController {
    case jisung
    case minjae
    case nick
    case seokhwan
    case seoyoung
    
    func initViewController() -> UIViewController {
        switch self {
        case .jisung:
            return JiSungViewController()
        case .minjae:
            return MinJaeViewController()
        case .nick:
            return NickViewController()
        case .seokhwan:
            return SeokHwanViewController()
        case .seoyoung:
            return SeoYoungViewController()
        }
    }
}

final class MainViewModel {
    let cards: [Card] = [
        Card(name: "이민재", memberType: .memberMan, birthday: "1996.10.16", imageName: "minjaeProfile", memberViewController: .minjae),
        Card(name: "박지성", memberType: .leader, birthday: "1991.07.06", imageName: "jisung_profile", memberViewController: .jisung),
        Card(name: "장승호", memberType: .memberMan, birthday: "1994.10.12", imageName: "nick_profile", memberViewController: .nick),
        Card(name: "한서영", memberType: .memberWoman, birthday: "2000.05.12", imageName: "sy_profile", memberViewController: .seoyoung),
        Card(name: "유석환", memberType: .memberMan, birthday: "1997.01.15", imageName: "SeokHwanProfile", memberViewController: .seokhwan)
    ]
}
