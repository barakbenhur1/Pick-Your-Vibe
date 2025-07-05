//
//  modifiers.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

struct BlinkModifier: ViewModifier {
    let duration: CGFloat
    @State private var blinking: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                // Animation will only start when blinking value changes
                blinking.toggle()
            }
    }
}

struct ScaleModifier: ViewModifier {
    let duration: CGFloat
    let value: CGFloat
    @State private var scale: Bool = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale ? .init(width: value, height: value) : .init(width: 1, height: 1))
            .animation(.easeInOut(duration: duration).repeatForever(), value: scale)
            .onAppear {
                // Animation will only start when scale value changes
                scale.toggle()
            }
    }
}

struct RotationModifier: ViewModifier {
    let duration: CGFloat
    let degrees: CGFloat
    @State private var rotation: Bool = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(rotation ? .degrees(degrees) : .degrees(-degrees))
            .animation(.easeInOut(duration: duration).repeatCount(2), value: rotation)
            .onAppear {
                // Animation will only start when rotation value changes
                rotation.toggle()
            }
    }
}

struct BounceModifier: ViewModifier {
    let duration: CGFloat
    let height: CGFloat
    
    @State private var bounce: Bool = false
    
    func body(content: Content) -> some View {
        content
            .offset(y: bounce ? 0 : height)
            .animation(.interpolatingSpring(duration: duration,
                                            bounce: height,
                                            initialVelocity: 2 * height),
                       
                       value: bounce)
            .onAppear {
                // Animation will only start when bounce value changes
                bounce.toggle()
            }
    }
}

extension View {
    func blink(duration: CGFloat = 0.8) -> some View {
        modifier(BlinkModifier(duration: duration))
    }
    
    func scale(duration: CGFloat = 0.8, value: CGFloat = 1.2) -> some View {
        modifier(ScaleModifier(duration: duration, value: value))
    }
    
    func rotation(duration: CGFloat = 0.8, degrees: CGFloat = 45) -> some View {
        modifier(RotationModifier(duration: duration, degrees: degrees))
    }
    
    func bounce(duration: CGFloat = 0.8, height: CGFloat = 4) -> some View {
        modifier(BounceModifier(duration: duration, height: height))
    }
}
