//
//  QueueManager.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

import Foundation

class QueueManager: ObservableObject {
    static let shared = QueueManager()
    private init() {}
    let value: DispatchQueue = DispatchQueue.main
}
