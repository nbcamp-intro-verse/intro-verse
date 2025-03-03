import Foundation

struct Card: Identifiable, Equatable {
    // MARK: - Properties
    let id: UUID
    let image: String

    // MARK: - Initializers
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
