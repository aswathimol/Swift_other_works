//
//  Theme.swift
//  Project1
//
//  Created by Aswathimol S(UST,IN) on 15/09/23.
//
import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable , Codable{
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        switch self {
        case .bubblegum:
            return .blue.opacity(0.6)
        case .buttercup:
            return .brown.opacity(0.6)
        case .indigo:
            return .indigo
        case .lavender:
            return .indigo.opacity(0.6)
        case .magenta:
            return .black
        case .navy:
            return .red
        case .orange:
            return .orange
        case .oxblood:
            return .brown
        case .periwinkle:
            return .purple
        case .poppy:
            return .green
        case .purple:
            return .pink
        case .seafoam:
            return .white
        case .sky:
            return .blue.opacity(0.9)
        case .tan:
            return .orange
        case .teal:
            return .teal
        case .yellow:
            return .yellow
        }
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
