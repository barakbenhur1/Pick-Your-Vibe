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
    func initalValue() {
        let value = VibeManager.shared.load()
        selectedVibe = value?.vibe
        count = value?.count ?? 0
    }
    
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
    
    func show(_ value: Bool) {
        var time: CGFloat = 0
        
        if value {
            time = 0.2
            withAnimation(.easeInOut(duration: time)) { animateVibe = true }
        }
        
        QueueManager.shared.value.asyncAfter(deadline: .now() + time) { [weak self] in
            guard let self else { return }
            animateVibe = false
            withAnimation(.easeInOut(duration: 0.3)) { self.showSelection = value }
        }
    }
    
    func getAttrString(count: Int) -> AttributedString {
        let one: AttributedString = "You’ve picked"
        var two: AttributedString = AttributedString("\(count)")
        two.foregroundColor = .red
        two.font = .body.bold()
        let three: AttributedString = "vibes"
        return one + " " + two + " " + three
    }
}
