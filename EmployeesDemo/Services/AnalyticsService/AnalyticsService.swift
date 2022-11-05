//
//  AnalyticsService.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation

protocol AnalyticsEvent {

    var name: String { get }

    var params: [String: String]? { get }
}

protocol AnalyticsServiceType {

    func logEvent(event: AnalyticsEvent)
}

final class AnalyticsService: AnalyticsServiceType {

    func logEvent(event: AnalyticsEvent) {
        var eventString = "\(event.name)"
        event
            .params?
            .forEach { key, value in
                eventString = eventString + " " + key + "=" + value
            }
        print("Log event \(Date()) -> \(eventString)")
    }
}
