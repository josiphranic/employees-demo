//
//  Employees.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation

struct Employees: Decodable, Equatable {

    let executiveTeam: [Employee]
    let operations: [Employee]
    let productTeam: [Employee]
    let marketingTeam: [Employee]
    let designTeam: [Employee]
    let developementTeam: [Employee]
    let dataTeam: [Employee]
    let qualityAssuranceTeam: [Employee]
    let customerServiceTeam: [Employee]

    private enum CodingKeys: String, CodingKey {
        
        case executiveTeam = "executive team"
        case operations
        case productTeam = "product team"
        case marketingTeam = "marketing team"
        case designTeam = "design team"
        case developementTeam = "development team"
        case dataTeam = "data team"
        case qualityAssuranceTeam = "quality assurance team"
        case customerServiceTeam = "customer service team"
    }
}
