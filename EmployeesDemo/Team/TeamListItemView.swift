//
//  TeamListItemView.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 02.11.2022..
//

import SwiftUI

struct TeamListItemView: View {

    let viewModel: TeamViewModel
    let titleColor: Color
    let descriptionColor: Color
    let itemBackgroudColor: Color

    var body: some View {
        VStack {
            Text(viewModel.name)
                .foregroundColor(titleColor)
                .padding(20)
            EmptyView()
                .frame(height: 20)
            Text("# 🧍🧍‍♀️🧍‍♂️ \(viewModel.employees.count)")
                .foregroundColor(descriptionColor)
                .padding(10)
        }
        .frame(maxWidth: .infinity)
        .background(itemBackgroudColor)
        .cornerRadius(20)
    }
}
