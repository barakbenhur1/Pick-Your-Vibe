//
//  VibeVM.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import Foundation
import SwiftUI

@Observable
class VibeVM: VibeViewModel {
    var selectedVibe: Vibe?
    var disabled: Bool = false
    var showSelection: Bool = false
    var animateVibe: Bool = false
    var didSelect: Bool = false
    var toolTip: Bool = false
    var count: Int = 0
    
    func selectVibe(_ vibe: Vibe?, complition: @escaping (_ value: Vibe?) -> ()) {
        guard let vibe else { return complition(nil) }
        guard selectedVibe != vibe else { return complition(nil) }
        VibeManager.shared.save(vibe: vibe)
        selectedVibe = vibe
        
        withAnimation {
            didSelect = true
            toolTip = count == 0
            count += 1
        }
        
        disabled = true
        
        complition(vibe)
        
        QueueManager.shared.value.asyncAfter(wallDeadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            disabled = false
            didSelect = false
        }
        
        QueueManager.shared.value.asyncAfter(wallDeadline: .now() + 4) { [weak self] in
            guard let self else { return }
            toolTip = false
        }
    }
}
