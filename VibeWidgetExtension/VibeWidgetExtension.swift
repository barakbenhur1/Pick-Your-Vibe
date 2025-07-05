//
//  VibeWidgetExtension.swift
//  VibeWidgetExtension
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import WidgetKit
import SwiftUI

struct VibeEntry: TimelineEntry {
    var date: Date
    let tracker: VibeTracker?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> VibeEntry {
        if let item = VibeManager.shared.load() {
            let tracker: VibeTracker = .init(vibe: item.vibe,
                                             count: item.count)
            return VibeEntry(date: .now,
                             tracker: tracker)
        }
        return VibeEntry(date: .now,
                         tracker: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (VibeEntry) -> ()) {
        if let item = VibeManager.shared.load() {
            let tracker: VibeTracker = .init(vibe: item.vibe,
                                             count: item.count)
            let entry = VibeEntry(date: .now,
                                  tracker: tracker)
            
            completion(entry)
        } else {
            completion(.init(date: .now,
                             tracker: nil))
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        if let item = VibeManager.shared.load() {
            let tracker: VibeTracker = .init(vibe: item.vibe,
                                             count: item.count)
            
            let entry = VibeEntry(date: .now.addingTimeInterval(2.4),
                                  tracker: tracker)
            
            var entries: [VibeEntry] = [entry]
            
            if item.count > 0 && item.count % 7 == 0 {
                let text = "you had 7 vibes"
                entries.append(.init(date: .now,
                                     tracker: .init(vibe: .init(name: "⭐⭐ \(text) ⭐⭐",
                                                                image: "",
                                                                color: .init(uiColor: .magenta)),
                                                    count: 0)))
                
                entries.append(.init(date: .now + 0.8,
                                     tracker: .init(vibe: .init(name: "⭐ \(text) ⭐",
                                                                image: "",
                                                                color: .init(uiColor: .red)),
                                                    count: 0)))
                
                entries.append(.init(date: .now + 1.8,
                                     tracker: .init(vibe: .init(name: text,
                                                                image: "",
                                                                color: .init(uiColor: .systemIndigo)),
                                                    count: 0)))
            }
            
            let timeline = Timeline(entries: entries,
                                    policy: .atEnd)
            
            completion(timeline)
        } else {
            let entry = VibeEntry(date: .now,
                                  tracker: nil)
            
            let timeline = Timeline(entries: [entry],
                                    policy: .atEnd)
            
            completion(timeline)
        }
    }
    
    //    func relevances() async -> WidgetRelevances<Void> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct VibeWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            if let selectedVibe = entry.tracker { vibe(selectedVibe) }
            else { emptyState }
        }
    }
}

struct VibeWidgetExtension: Widget {
    let kind: String = "VibeWidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Link(destination: URL(string: "widget://main")!) {
                    VibeWidgetExtensionEntryView(entry: entry)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .containerBackground(.yellow, for: .widget)
                }
            } else {
                Link(destination: URL(string: "widget://main")!) {
                    VibeWidgetExtensionEntryView(entry: entry)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .background(.yellow)
                        .padding()
                }
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

extension VibeWidgetExtension {
    @ViewBuilder
    private func background() -> some View {
        Image("background")
            .resizable()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

extension VibeWidgetExtensionEntryView {
    @ViewBuilder
    private func vibe(_ value: VibeTracker) -> some View {
        VStack {
            let textView = Text(value.vibe.name)
                .multilineTextAlignment(.center)
                .font(.custom("", size: 18))
                .foregroundStyle(value.vibe.color.value)
                .padding(.bottom, 8)
                .minimumScaleFactor (0.1)
            
            if value.count > 0 {
                Text("your vibe today")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .shadow(radius: 2)
                    .minimumScaleFactor (0.1)
                
                Link(destination: URL(string: "widget://select")!) {
                    Text(value.vibe.image)
                        .multilineTextAlignment(.center)
                        .font(.custom("", size: 100))
                        .shadow(radius: 4)
                        .padding(.vertical, 8)
                        .minimumScaleFactor (0.16)
                    
                    textView
                }
            } else { textView }
            
            if value.count > 0 {
                Text(getAttrString(count: value.count))
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .minimumScaleFactor (0.1)
            }
        }
        .transition(.opacity)
    }
    
    @ViewBuilder
    private var emptyState: some View {
        VStack {
            Text("No vibe yet")
                .foregroundStyle(.black)
                .padding(.bottom, 8)
            
            Link(destination: URL(string: "widget://select")!) {
                Text("pick one!")
                    .foregroundStyle(.teal)
            }
        }
    }
    
    private func getAttrString(count: Int) -> AttributedString {
        let one: AttributedString = "You’ve picked"
        var two: AttributedString = AttributedString("\(count)")
        two.foregroundColor = .red
        two.font = .body.bold()
        let three: AttributedString = "vibes"
        return one + " " + two + " " + three
    }
}

struct VibeInteractiveWidget: Widget {
    let kind: String = "VibeWidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Link(destination: URL(string: "widget://main")!) {
                VibeWidgetExtensionEntryView(entry: entry)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .background(.yellow)
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
        .configurationDisplayName("Vibe Widget")
        .description("Track your vibe directly from the Home Screen")
    }
}

extension VibeInteractiveWidget {
    @ViewBuilder
    private func background() -> some View {
        Image("background")
            .resizable()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

#Preview(as: .systemMedium) {
    VibeWidgetExtension()
} timeline: {
    VibeEntry(date: .now,
              tracker: .init(vibe: .init(name: "Joy",
                                         image: "😂",
                                         color: .init(uiColor: .purple)),
                             count: 12))
}
