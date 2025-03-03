import Foundation

class CardViewModel {
    private(set) var cards: [Card]
    @Published var activeCard: Card?

    init(cards: [Card]) {
        self.cards = cards
        self.activeCard = cards.first
    }

    func setActiveCard(_ card: Card) {
        activeCard = card
    }

    func loadCards() {}
}
