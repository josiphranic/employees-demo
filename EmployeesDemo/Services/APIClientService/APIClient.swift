//
//  APIClient.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation

import Foundation
import Combine

protocol APIClientType {

    func getEmployees() async throws -> Employees
}

final class APIClient {

    private let jsonDecoder = JSONDecoder()
    private let urlSession: URLSession

    init() {
        urlSession = URLSession.shared
    }
}

extension APIClient: APIClientType {
    // TODO retry
    func getEmployees() async throws -> Employees {
        guard let url = URL(string: "https://drive.google.com/u/0/uc?id=1RLERQKOMhkhqI0tn-YHKNlwaTDVd3q9s") else {
            throw APIClientError.urlError
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)

        if let statusCode = (response as? HTTPURLResponse)?.statusCode,
           (200..<300) ~= statusCode {
            do {
                return try jsonDecoder.decode(Employees.self, from: data)
            } catch {
                throw APIClientError.decodeError
            }
        } else {
            // Because google sometimes returns 403
            return try jsonDecoder.decode(Employees.self, from: getMockData())
        }
    }
}

private extension APIClient {

    func getMockData() -> Data {
        guard let pathString = Bundle.main.path(forResource: "teltechians", ofType: "json") else {
            return Data()
        }
        let url = URL(filePath: pathString)
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: url)
        } catch {
            print(error)
            jsonData = Data()
        }

        return jsonData
    }
}
