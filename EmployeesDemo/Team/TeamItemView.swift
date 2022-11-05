//
//  TeamItemView.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 03.11.2022..
//

import SwiftUI

struct TeamItemView: View {

    let employee: Employee
    let titleColor: Color
    let descriptionColor: Color
    let backgroundColor: Color
    let itemBackgroudColor: Color

    var body: some View {
        VStack {
            Text("\(employee.name) \(employee.surname)")
                .foregroundColor(titleColor)
                .padding(10)
            Text(employee.title)
                .foregroundColor(descriptionColor)
                .padding(10)
            Text(employee.intro)
                .foregroundColor(descriptionColor)
                .padding(10)
            Text(employee.description)
                .foregroundColor(descriptionColor)
                .padding(10)
        }
        .background(itemBackgroudColor)
        .cornerRadius(20)
        .padding(20)
    }
}
