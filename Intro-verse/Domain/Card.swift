import Foundation

struct Card: Identifiable, Equatable {
    let id: UUID
    let image: String

    init(image: String) {
        self.id = UUID()
        self.image = image
    }
}

let cards: [Card] = [
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
]
