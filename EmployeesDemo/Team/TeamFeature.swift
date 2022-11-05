//
//  TeamFeature.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 02.11.2022..
//

import Foundation

struct TeamFeature {

    struct State: Equatable {

        var palette: ThemePalette
        var teamViewModels: [TeamViewModel]?
        var teamSelected: TeamViewModel?
        var themeType: ThemeType
    }

    enum Action: Equatable {

        case changeTheme
        case teamAppeared(String)
    }
}
