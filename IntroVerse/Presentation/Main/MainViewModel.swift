import Foundation
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
        Card(name: "이민재", memberType: .memberMan, birthday: "19000101", imageName: "minjaeProfile", memberViewController: .minjae),
        Card(name: "박지성", memberType: .leader, birthday: "19000101", imageName: "jisung_profile", memberViewController: .jisung),
        Card(name: "장승호", memberType: .memberMan, birthday: "19000101", imageName: "nick_profile", memberViewController: .nick),
        Card(name: "한서영", memberType: .memberWoman, birthday: "19000101", imageName: "sy_profile", memberViewController: .seoyoung),
        Card(name: "유석환", memberType: .memberMan, birthday: "19000101", imageName: "SeokHwanProfile", memberViewController: .seokhwan),
        Card(name: "이민재", memberType: .memberMan, birthday: "19000101", imageName: "minjaeProfile", memberViewController: .minjae),
        Card(name: "박지성", memberType: .leader, birthday: "19000101", imageName: "jisung_profile", memberViewController: .jisung),
    ]
    let selectedCardIndex = 0
}
