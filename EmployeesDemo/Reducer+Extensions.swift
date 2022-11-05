//
//  Reducer+Extensions.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import Foundation
import ComposableArchitecture

extension ReducerProtocol {

    func logActions() -> some ReducerProtocol<State, Action> {
        Reduce { state, action in
            print("Received action: \(action)")

            return reduce(into: &state, action: action)
        }
    }
}
