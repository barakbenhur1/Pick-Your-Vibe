//
//  VibeIntent.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import AppIntents

struct VibeIntent: AppIntent {
    static var title: LocalizedStringResource = "Pick Your Vibe"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
