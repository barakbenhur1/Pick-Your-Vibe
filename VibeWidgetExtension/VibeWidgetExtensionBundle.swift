//
//  VibeWidgetExtensionBundle.swift
//  VibeWidgetExtension
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import WidgetKit
import SwiftUI

@main
struct VibeWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        VibeWidgetExtension()
        VibeWidgetExtensionControl()
        VibeWidgetExtensionLiveActivity()
    }
}
