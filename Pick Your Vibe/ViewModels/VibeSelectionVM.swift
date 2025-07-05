//
//  VibeSelectionVM.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

import Foundation
import SwiftUI

@Observable
class VibeSelectionVM: VibeSelectionViewModel {
    let vibes: Vibes = .vibes
    var disable: Bool = false
    var selectedVibe: Vibe?
    
    func selectVibe(_ vibe: Vibe?, complition: @escaping (_ value: Vibe?) -> ()) {
        withAnimation(.smooth(duration: 0.2)) { selectedVibe = vibe }
        disable = true
        QueueManager.shared.value.asyncAfter(wallDeadline: .now() + 0.2) { [weak self] in
            guard let self else { return complition(nil) }
            guard let selectedVibe else { return }
            let value = selectedVibe
            
            withAnimation(.smooth(duration: 0.05)) { self.selectedVibe = nil }
           
            QueueManager.shared.value.asyncAfter(wallDeadline: .now() + 0.05) { [weak self] in
                guard let self else { return complition(nil) }
                complition(value)
                disable = false
            }
        }
    }
}
