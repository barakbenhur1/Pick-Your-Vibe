//
//  VibeDataSource.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

typealias Vibes = [Vibe]

extension Vibes {
    static let vibes: [Vibe] =
    [.init(name: "focus",
           image: "🧠",
           color: .init(uiColor: .purple)),
     .init(name: "power",
           image: "💪",
           color: .init(uiColor: .orange)),
     .init(name: "chill",
           image: "😴",
           color: .init(uiColor: .blue)),
     .init(name: "joy",
           image: "😂",
           color: .init(uiColor: .systemPink))]
}
