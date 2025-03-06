import Foundation

struct Card: Identifiable, Equatable {
    enum MemberType: String {
        case leader = "👑 팀장"
        case memberMan = "👱 팀원"
        case memberWoman = "👩 팀원"
    }

    // MARK: - Properties
    let id: UUID
    let name: String
    let memberType: Card.MemberType
    let birthday: String
    let imageName: String

    // MARK: - Initializers
    init(name: String, memberType: Card.MemberType, birthday: String, imageName: String) {
        self.id = UUID()
        self.name = name
        self.memberType = memberType
        self.birthday = "19000101"
        self.imageName = "image"
    }
}
