//
//  GroupManager.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import Foundation
import WidgetKit

struct VibeTracker: Codable, Equatable {
    let vibe: Vibe
    let count: Int
}

class VibeManager: ObservableObject {
    static let shared: VibeManager = VibeManager()
    
    private let userDefaults: UserDefaults?
    private let key: String
    
    private init() {
        userDefaults =  UserDefaults(suiteName: "group.vibe.container")
        key = "vibe"
    }
    
    func save(vibe: Vibe) {
        let currentCount = load()?.count
        let vibeTracker = VibeTracker(vibe: vibe, count: currentCount == nil ? 1 : currentCount! + 1)
        guard let data = try? JSONEncoder().encode(vibeTracker) else { return }
        userDefaults?.set(data, forKey: key)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func load() -> VibeTracker? {
        guard let data = userDefaults?.object(forKey: key) as? Data else { return nil }
        let decoded = try? JSONDecoder().decode(VibeTracker.self, from: data)
        return decoded
    }
}
