//
//  VibeWidgetExtensionLiveActivity.swift
//  VibeWidgetExtension
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct VibeWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct VibeWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: VibeWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension VibeWidgetExtensionAttributes {
    fileprivate static var preview: VibeWidgetExtensionAttributes {
        VibeWidgetExtensionAttributes(name: "World")
    }
}

extension VibeWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: VibeWidgetExtensionAttributes.ContentState {
        VibeWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: VibeWidgetExtensionAttributes.ContentState {
         VibeWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: VibeWidgetExtensionAttributes.preview) {
   VibeWidgetExtensionLiveActivity()
} contentStates: {
    VibeWidgetExtensionAttributes.ContentState.smiley
    VibeWidgetExtensionAttributes.ContentState.starEyes
}
