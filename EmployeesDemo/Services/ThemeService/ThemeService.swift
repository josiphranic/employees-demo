//
//  ThemeService.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 02.11.2022..
//

import Foundation
import SwiftUI

enum ThemeType: Equatable {
    
    case light
    case dark
}

struct ThemePalette: Equatable {

    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    let primaryTextColor: Color
    let secondaryTextColor: Color
}

final class ThemeService {

    private(set) var themeType: ThemeType = .dark
    private var primaryBackground: Color {
        switch themeType {
        case .dark:
            return Color(red: 42 / 255, green: 60 / 255, blue: 68 / 255)
        case .light:
            return Color(red: 273 / 255, green: 241 / 255, blue: 250 / 255)
        }
    }
    private var secondaryBackground: Color {
        switch themeType {
        case .dark:
            return Color(red: 48 / 255, green: 68 / 255, blue: 78 / 255)
        case .light:
            return Color(red: 212 / 255, green: 245 / 255, blue: 233 / 255)
        }
    }
    private var primaryTextColor: Color {
        switch themeType {
        case .dark:
            return Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
        case .light:
            return Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
        }
    }
    private var secondaryTextColor: Color {
        switch themeType {
        case .dark:
            return Color(red: 150 / 255, green: 167 / 255, blue: 175 / 255)
        case .light:
            return Color(red: 71 / 255, green: 94 / 255, blue: 105 / 255)
        }
    }

    func updateTheme(type: ThemeType) {
        themeType = type
    }

    func getPalette() -> ThemePalette {
        ThemePalette(primaryBackgroundColor: primaryBackground,
                     secondaryBackgroundColor: secondaryBackground,
                     primaryTextColor: primaryTextColor,
                     secondaryTextColor: secondaryTextColor)
    }

    func toggleTheme() {
        switch themeType {
        case .light:
            themeType = .dark
        case .dark:
            themeType = .light
        }
    }
}
