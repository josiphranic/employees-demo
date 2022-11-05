//
//  APIClientMock.swift
//  EmployeesDemoTests
//
//  Created by Josip Hranic on 05.11.2022..
//

import Foundation
@testable import EmployeesDemo

final class APIClientMock: APIClientType {

    func getEmployees() async throws -> Employees {
        getMockEmployees()
    }
}

extension APIClientMock {

    func getMockEmployees() -> Employees {
        Employees(executiveTeam: [],
                  operations: [],
                  productTeam: [],
                  marketingTeam: [],
                  designTeam: [],
                  developementTeam: [],
                  dataTeam: [],
                  qualityAssuranceTeam: [],
                  customerServiceTeam: [])
    }
}
