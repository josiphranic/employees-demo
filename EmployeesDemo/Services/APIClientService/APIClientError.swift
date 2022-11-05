//
//  APIClientError.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation

enum APIClientError: Error {

    case responseError
    case urlError
    case decodeError
}
