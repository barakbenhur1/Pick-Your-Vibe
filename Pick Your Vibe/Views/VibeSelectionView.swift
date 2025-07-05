//
//  VibeSelectionView.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

typealias VibeSelection = (Vibe?) -> ()

struct VibeSelectionView: View {
    @EnvironmentObject private var queue: QueueManager
    
    private let vibes = VibeDataSource()
    @State private var disable: Bool = false
    @State private var selected: Vibe?
    
    let didSelect: VibeSelection
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan, .teal],
                           startPoint: .bottomTrailing,
                           endPoint: .topLeading).ignoresSafeArea()
            VStack {
                topView
                vibeMenu
                    .padding(.top, 50)
                    .padding()
            }
            .padding(.top, 50)
        }
        .disabled(disable)
    }
    
    private func selectVibe(_ vibe: Vibe) {
        withAnimation(.smooth(duration: 0.2)) { selected = vibe }
        disable = true
        queue.value.asyncAfter(wallDeadline: .now() + 0.2) {
            guard let selected else { return }
            let value = selected
            withAnimation(.smooth(duration: 0.2)) { self.selected = nil }
            queue.value.asyncAfter(wallDeadline: .now() + 0.2) {
                didSelect(value)
                self.disable = false
            }
        }
    }
}

extension VibeSelectionView {
    @ViewBuilder
    private var topView: some View {
        ZStack {
            Text("Pick Vibe")
                .font(.title)
            Button {
                didSelect(nil)
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .font(.title)
                    Spacer()
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private var vibeMenu: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 44) {
                ForEach(vibes.items, id: \.id) { vibe in
                    Button { selectVibe(vibe) }
                    label: { vibeButton(vibe)  }
                        .scaleEffect(selected == vibe ? 1.1 : 1)
                        .padding(.horizontal, 20)
                        .buttonStyle(VibeButton())
                }
                Spacer()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    @ViewBuilder
    private func vibeButton(_ vibe: Vibe) -> some View {
        HStack(spacing: 104) {
            Text(vibe.image)
                .font(.custom("", size: 32))
            Text(vibe.name)
                .foregroundStyle(selected == vibe ? .white : vibe.color.value)
                .font(.custom("", size: 32))
            Spacer()
        }
        .background { selected == vibe ? Color.gray.opacity(0.4) : .clear }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct VibeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.gray.opacity(0.4) : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .ignoresSafeArea()
    }
}

#Preview {
    VibeSelectionView{ _  in }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(QueueManager.shared)
}

