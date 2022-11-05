//
//  TeamListView.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 02.11.2022..
//

import SwiftUI
import ComposableArchitecture

struct TeamListView: View {

    let teamStore: Store<TeamFeature.State, Never>
    
    var body: some View {
        WithViewStore(teamStore) { teamViewStore in
            ScrollView {
                if let teamViewModels = teamViewStore.teamViewModels {
                    LazyVStack(spacing: 0) {
                        ForEach(teamViewModels, id: \.self) { team in
                            NavigationLink(value: team,
                                           label: {
                                TeamListItemView(viewModel: team,
                                                 titleColor: teamViewStore.palette.primaryTextColor,
                                                 descriptionColor: teamViewStore.palette.secondaryTextColor,
                                                 itemBackgroudColor: teamViewStore.palette.secondaryBackgroundColor)
                                .padding(20)
                            })
                        }
                    }
                } else {
                    Spacer()
                    Text("👻 No data")
                        .shimmering()
                    Spacer()
                }
            }
            .background(teamViewStore.palette.primaryBackgroundColor)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
