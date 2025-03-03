import Foundation

final class MainViewModel {
    // MARK: - Properties
    private(set) var cards: [Card]
    @Published var activeCard: Card?

    // MARK: - Initializers
    init(cards: [Card]) {
        self.cards = cards
        self.activeCard = cards.first
    }

    // MARK: - Methods
    func setActiveCard(_ card: Card) {
        activeCard = card
    }

    func loadCards() {

    }
}
