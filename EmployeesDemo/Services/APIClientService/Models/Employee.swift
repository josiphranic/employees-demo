//
//  Employee.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation

struct Employee: Decodable, Hashable {

    let name: String
    let surname: String
    let image: String
    let title: String
    let agency: String
    let intro: String
    let description: String
}
