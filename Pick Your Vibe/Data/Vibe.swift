//
//  VibeDataSource.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 04/07/2025.
//

import SwiftUI

struct Vibe: Codable, Equatable, Identifiable {
    static func == (lhs: Vibe, rhs: Vibe) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.color == rhs.color
    }
    
    var id = UUID()
    let name: String
    let image: String
    let color: MyColor
}

extension Vibe {
    struct MyColor : Codable, Equatable {
        var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        
        var uiColor : UIColor {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        
        var value : Color {
            return Color(uiColor: uiColor)
        }
        
        init(uiColor : UIColor) {
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
}

