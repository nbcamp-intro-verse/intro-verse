//
//  CardViewModel.swift
//  Intro-verse

import Foundation

class CardViewModel {
    // MARK : - Property
    private(set) var cards: [Card]
    @Published var activeCard: Card?
    
    init(cards: [Card]) {
        self.cards = cards
        self.activeCard = cards.first
    }
    
    // MARK - Business Logic?
    func setActiveCard(_ card: Card) {
        activeCard = card
    }
    
    // Load Cards ? Maybe
    func loadCards() {}
}
