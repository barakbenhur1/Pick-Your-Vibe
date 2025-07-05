//
//  VibeView.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI
import SwiftUITooltip

struct VibeView<VM: VibeViewModel>: View {
    @ObservedObject var vm: VM
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                background
                    .ignoresSafeArea()
                
                content
                    .onTapGesture { vm.show(true) }
                
                vibeSelectionView(width: proxy.size.width)
                    .ignoresSafeArea()
            }
            .disabled(vm.disabled)
        }
        .onAppear { vm.initalValue() }
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
                .scale()
            
            Text(vm.getAttrString(count: vm.count))
                .multilineTextAlignment(.center)
                .font(.body)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func vibeSelectionView(width: CGFloat) -> some View {
        VibeSelectionView(vm: VibeSelectionVM()) { vibe in
            vm.selectVibe(vibe) { _ in
                vm.show(false)
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
                    .bounce()
            } else {
                image
                    .scaleEffect(vm.animateVibe ? .init(width: 1.1,
                                                        height: 1.1) : .init(width: 1,
                                                                             height: 1))
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
    private var content: some View {
        ZStack {
            if let selectedVibe = vm.selectedVibe { vibe(selectedVibe) }
            else { emptyState }
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
    
    @ViewBuilder
    private var background: some View {
        Image("background")
            .resizable()
    }
}

#Preview {
    VibeView(vm: VibeVM())
}
