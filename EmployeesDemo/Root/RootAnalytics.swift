//
//  RootAnalytics.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation

enum RootAnalyticEventSource {

    case root
    case team
}

enum RootAnalyticEvent: AnalyticsEvent {
    
    case loadData
    case loadingSuccess
    case loadFailed
    case themeChange(RootAnalyticEventSource)

    var name: String {
        switch self {
        case .loadData:
            return "LoadData"
        case .loadingSuccess:
            return "LoadingSuccess"
        case .loadFailed:
            return "LoadFailed"
        case .themeChange:
            return "ThemeChange"
        }
    }

    var params: [String : String]? {
        switch self {
        case .loadData, .loadingSuccess, .loadFailed:
            return nil
        case .themeChange(let source):
            switch source {
            case .root:
                return ["Source": "Root"]
            case .team:
                return ["Source": "Team"]
            }
        }
    }
}
