//
//  Pick_Your_VibeApp.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

@main
struct Pick_Your_VibeApp: App {
    private let persistenceController = PersistenceController.shared
    private let vibeManager: VibeManager = VibeManager.shared
    private let queue: QueueManager = QueueManager.shared
    
    var body: some Scene {
        WindowGroup {
            let vm = VibeVM()
            VibeView(vm: vm)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(queue)
                .environmentObject(vibeManager)
                .onOpenURL { url in vm.showSelection = url.absoluteString.contains("select") }
        }
    }
}
