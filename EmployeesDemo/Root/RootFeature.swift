//
//  RootFeature.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation
import ComposableArchitecture

enum RootLoadingState: Equatable {

    case idle
    case loading
    case failed
}

struct RootReducer: ReducerProtocol {

    let apiClient: APIClientType
    let themeService: ThemeService
    let analyticsServiceType: AnalyticsServiceType

    struct State: Equatable {
        
        var employees: Employees?
        var loadingState: RootLoadingState = .idle
        var themePallete: ThemePalette
        var themeType: ThemeType
        var teamSelected: TeamViewModel?
    }

    enum Action: Equatable {
        
        case appBecameActiv
        case loadButtonTap
        case loaded(Employees)
        case loadingFailed
        case changeTheme
        case teamAction(TeamFeature.Action)
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .appBecameActiv, .loadButtonTap:
            state.loadingState = .loading
            analyticsServiceType.logEvent(event: RootAnalyticEvent.loadData)

            return .task(priority: .utility,
                         operation: { [apiClient] in
                if let employees = try? await apiClient.getEmployees() {
                    return .loaded(employees)
                } else {
                    return .loadingFailed
                }
            },
                         catch: { _ in .loadingFailed })
        case .loaded(let employees):
            state.employees = employees
            state.loadingState = .idle
            analyticsServiceType.logEvent(event: RootAnalyticEvent.loadingSuccess)

            return .none
        case .loadingFailed:
            state.loadingState = .failed
            analyticsServiceType.logEvent(event: RootAnalyticEvent.loadFailed)
            
            return .none
        case .changeTheme:
            themeService.toggleTheme()
            state.themeType = themeService.themeType
            state.themePallete = themeService.getPalette()
            analyticsServiceType.logEvent(event: RootAnalyticEvent.themeChange(.root))

            return .none
        case .teamAction(let action):
            switch action {
            case .changeTheme:
                themeService.toggleTheme()
                state.themeType = themeService.themeType
                state.themePallete = themeService.getPalette()
                analyticsServiceType.logEvent(event: RootAnalyticEvent.themeChange(.team))

                return .none
            case .teamAppeared(let teamName):
                analyticsServiceType.logEvent(event: TeamAnalyticsEvent.teamAppeared(teamName))

                return .none
            }
        }
    }
}
