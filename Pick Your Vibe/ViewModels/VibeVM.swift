//
//  VibeVM.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import Foundation

class VibeVM: ObservableObject {
    @Published var selectedVibe: Vibe?
    @Published var showSelection: Bool = false
    @Published var animateVibe: Bool = false
    @Published var didSelect: Bool = false
    @Published var toolTip: Bool = false
    @Published var count: Int = 0
}
