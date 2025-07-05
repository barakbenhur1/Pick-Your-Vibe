//
//  VibeViewModel.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

import Foundation

protocol VibeViewModel: BaseViewModel {
    var selectedVibe: Vibe? { get set }
    var showSelection: Bool { get set }
    var disabled: Bool { get set }
    var animateVibe: Bool { get set }
    var didSelect: Bool { get set }
    var toolTip: Bool { get set }
    var count: Int { get set }
    
    func initalValue()
    func show(_ value: Bool)
    func getAttrString(count: Int) -> AttributedString 
}
