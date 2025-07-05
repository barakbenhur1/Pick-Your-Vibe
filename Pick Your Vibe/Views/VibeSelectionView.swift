//
//  VibeSelectionView.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

typealias VibeSelection = (Vibe?) -> ()

struct VibeSelectionView<VM: VibeSelectionViewModel>: View {
    @ObservedObject var vm: VM
    let didSelect: (_ vibe: Vibe?) -> ()
    
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            
            VStack {
                topView
                vibeMenu
                    .padding(.top, 50)
            }
            .padding(.top, 50)
        }
        .disabled(vm.disable)
    }
    
    private func selectVibe(_ value: Vibe) {
        vm.selectVibe(value) { value in didSelect(value) }
    }
}

extension VibeSelectionView {
    @ViewBuilder
    private var topView: some View {
        ZStack {
            Text("Pick Vibe")
                .font(.title)
            
            HStack {
                Button { didSelect(nil) }
                label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .font(.title)
                }
                
                Spacer()
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private var vibeMenu: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 44) {
                ForEach(vm.vibes, id: \.id) { vibe in
                    Button { selectVibe(vibe) }
                    label: { vibeButton(vibe)  }
                        .scaleEffect(vm.selectedVibe == vibe ? 1.1 : 1)
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
        ZStack {
            HStack {
                Text(vibe.image)
                    .font(.custom("", size: 32))
                    .minimumScaleFactor(0.1)
                
                Spacer()
            }
            
            Text(vibe.name)
                .foregroundStyle(vm.selectedVibe == vibe ? .white : vibe.color.value)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .minimumScaleFactor(0.1)
        }
        .background { vm.selectedVibe == vibe ? Color.gray.opacity(0.4) : .clear }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private var background: some View {
        LinearGradient(colors: [.blue, .cyan, .teal],
                       startPoint: .bottomTrailing,
                       endPoint: .topLeading)
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
    VibeSelectionView(vm: VibeSelectionVM()) { _ in }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

