import Foundation

final class MainViewModel {
    let cards: [Card] = [
        Card(name: "이민재", memberType: .memberMan, birthday: "19000101", imageName: "assetName"),
        Card(name: "박지성", memberType: .leader, birthday: "19000101", imageName: "assetName"),
        Card(name: "장승호", memberType: .memberMan, birthday: "19000101", imageName: "assetName"),
        Card(name: "한서영", memberType: .memberWoman, birthday: "19000101", imageName: "assetName"),
        Card(name: "유석환", memberType: .memberMan, birthday: "19000101", imageName: "assetName"),
    ]
    let selectedCardIndex = 0
}
