//
//  VibeView.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI
import SwiftUITooltip

struct VibeView<VM: VibeViewModel>: View {
    @EnvironmentObject private var queue: QueueManager
    @EnvironmentObject private var vibeManager: VibeManager
    
    @State var vm: VM
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
               Image("background")
                    .resizable()
                    .ignoresSafeArea()
                ZStack {
                    if let selectedVibe = vm.selectedVibe { vibe(selectedVibe) }
                    else { emptyState }
                }
                .onTapGesture { show(true) }
                
                vibeSelectionView(width: proxy.size.width)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            let value = vibeManager.load()
            vm.selectedVibe = value?.vibe
            vm.count = value?.count ?? 0
        }
    }
    
    private func show(_ value: Bool) {
        var time: CGFloat = 0
        if value {
            time = 0.2
            withAnimation(.easeInOut(duration: time)) { vm.animateVibe = true }
        }
        queue.value.asyncAfter(deadline: .now() + time) {
            vm.animateVibe = false
            withAnimation(.easeInOut(duration: 0.3)) { vm.showSelection = value }
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

extension VibeView {
    @ViewBuilder
    private func vibe(_ vibe: Vibe) -> some View {
        VStack(spacing: 20) {
            Text("Your vibe\ntoday")
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .font(.largeTitle)
                .padding(.top, 160)
                .padding(.bottom, 60)
            
            image(vibe.image)
            
            Text(vibe.name)
                .font(.largeTitle)
                .foregroundStyle(vibe.color.value)
                .scale(duration: 1.6)
            
            Text(getAttrString(count: vm.count))
                .multilineTextAlignment(.center)
                .font(.body)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func vibeSelectionView(width: CGFloat) -> some View {
        VibeSelectionView(vm: VibeSelectionVM()) { vibe in
            vm.selectVibe(vibe) { _ in
                show(false)
            }
        }
        .opacity(vm.showSelection ? 1 : 0)
        .clipShape(RoundedRectangle(cornerRadius: vm.showSelection ? 0 : width / 2))
    }
    
    @ViewBuilder
    private func image(_ value: String) -> some View {
        let image = Text(value)
            .font(.custom("", size: 100))
            .shadow(color: .black,
                    radius: 4)
        
        let imageWrapper = ZStack {
            if vm.didSelect {
                image
                    .bounce(duration: 1.6)
            } else {
                image
                    .scaleEffect(vm.animateVibe ? .init(width: 1.1, height: 1.1) : .init(width: 1, height: 1))
            }
        }
        
        imageWrapper
            .tooltip(vm.toolTip,
                     side: .left) {
                Text("Tap here\nto change vibe!")
                    .multilineTextAlignment(.center)
            }
    }
    
    @ViewBuilder
    private var emptyState: some View {
        VStack {
            Text("No vibe yet")
                .foregroundStyle(.black)
                .font(.largeTitle)
                .foregroundStyle(.black)
                .font(.largeTitle)
            
            Text("pick one!")
                .foregroundStyle(.teal)
                .font(.largeTitle)
                .blink()
        }
    }
}

#Preview {
    VibeView(vm: VibeVM())
        .environmentObject(QueueManager.shared)
}
