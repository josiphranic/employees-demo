//
//  TeamAnalytics.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation

enum TeamAnalyticsEvent: AnalyticsEvent {

    case teamAppeared(String)

    var name: String {
        switch self {
        case .teamAppeared:
            return "TeamAppeared"
        }
    }
    
    var params: [String : String]? {
        switch self {
        case .teamAppeared(let teamName):
            return ["TeamName": teamName]
        }
    }
}
