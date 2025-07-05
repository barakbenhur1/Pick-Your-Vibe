//
//  Pick_Your_VibeApp.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

@main
struct Pick_Your_VibeApp: App {
    
    var body: some Scene {
        WindowGroup {
            let vm = VibeVM()
            VibeView(vm: vm)
                .onOpenURL { url in vm.showSelection = url.absoluteString.contains("select") }
        }
    }
}
