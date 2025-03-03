//
//  Card.swift
//  Intro-verse
//  Define Card Models

import Foundation

// Model Layer
struct Card: Identifiable, Equatable {
    let id: UUID
    let image: String
    
    init(image: String) {
        self.id = UUID()
        self.image = image
    }
}

// Example Usage
let cards: [Card] = [
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
    .init(image: ""),
]
