//
//  APIClientFailedMock.swift
//  EmployeesDemoTests
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation
@testable import EmployeesDemo

final class APIClientFailedMock: APIClientType {

    func getEmployees() async throws -> Employees {
        throw APIClientError.responseError
    }
}
