//
//  VibeViewModel.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

protocol VibeViewModel: BaseViewModel {
    var selectedVibe: Vibe? { get set }
    var showSelection: Bool { get set }
    var animateVibe: Bool { get set }
    var didSelect: Bool { get set }
    var toolTip: Bool { get set }
    var count: Int { get set }
}
