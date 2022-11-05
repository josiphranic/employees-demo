//
//  EmployeesDemoApp.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import SwiftUI
import ComposableArchitecture

@main
struct EmployeesDemoApp: App {

    private let apiClient = APIClient()
    private let themeService = ThemeService()
    private let analyticsService = AnalyticsService()

    var body: some Scene {
        WindowGroup {
            RootView(rootStore: Store(initialState: RootReducer.State(themePallete: themeService.getPalette(),
                                                                      themeType: themeService.themeType),
                                      reducer: RootReducer(apiClient: apiClient,
                                                           themeService: themeService,
                                                           analyticsServiceType: analyticsService)))
        }
    }
}
