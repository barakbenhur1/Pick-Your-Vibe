//
//  VibeDataSource.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

typealias Vibes = [Vibe]

extension Vibes {
    static let vibes: [Vibe] =
    [.init(name: "Focus",
           image: "🧠",
           color: .init(uiColor: .purple)),
     .init(name: "Power",
           image: "💪",
           color: .init(uiColor: .orange)),
     .init(name: "Chill",
           image: "😴",
           color: .init(uiColor: .blue)),
     .init(name: "Joy",
           image: "😂",
           color: .init(uiColor: .systemPink))]
}
