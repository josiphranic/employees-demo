//
//  AnalyticsServiceMock.swift
//  EmployeesDemoTests
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation
@testable import EmployeesDemo

final class AnalyticsServiceMock: AnalyticsServiceType {

    func logEvent(event: AnalyticsEvent) {
        var eventString = "\(event.name)"
        event
            .params?
            .forEach { key, value in
                eventString = eventString + " " + key + "=" + value
            }
        print("Mock log event \(Date()) -> \(eventString)")
    }
}
