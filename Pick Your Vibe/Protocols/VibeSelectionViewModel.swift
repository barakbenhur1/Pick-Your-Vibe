//
//  VibeSelectionViewModel.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

protocol VibeSelectionViewModel: BaseViewModel {
    var disable: Bool { get set }
    var selectedVibe: Vibe? { get set }
    var vibes: Vibes { get }
}
