//
//  TeamView.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import SwiftUI
import ComposableArchitecture

struct TeamView: View {

    let teamStore: Store<TeamFeature.State, TeamFeature.Action>
    
    var body: some View {
        WithViewStore(teamStore) { teamViewStore in
            VStack {
                if let teamSelected = teamViewStore.teamSelected {
                    ScrollView {
                        LazyVStack {
                            ForEach(teamSelected.employees, id: \.self) { employee in
                                VStack(spacing: 20) {
                                    TeamItemView(employee: employee,
                                                 titleColor: teamViewStore.palette.primaryTextColor,
                                                 descriptionColor: teamViewStore.palette.secondaryTextColor,
                                                 backgroundColor: teamViewStore.palette.primaryBackgroundColor,
                                                 itemBackgroudColor: teamViewStore.palette.secondaryBackgroundColor)
                                }
                            }
                        }
                    }
                    .navigationTitle(teamSelected.name)
                    .onAppear {
                        teamViewStore.send(.teamAppeared(teamSelected.name))
                    }
                    Spacer()
                } else {
                    Spacer()
                    Text("👻 No data")
                        .shimmering()
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(teamViewStore.palette.primaryBackgroundColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        switch teamViewStore.themeType {
                        case .light:
                            Button("🌚") {
                                teamViewStore.send(.changeTheme)
                            }
                            .font(.system(size: 30))
                        case .dark:
                            Button("🌞") {
                                teamViewStore.send(.changeTheme)
                            }
                            .font(.system(size: 30))
                        }
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(teamViewStore.palette.secondaryBackgroundColor, for: .navigationBar)
            .toolbarColorScheme(teamViewStore.themeType == .dark ? .dark : .light, for: .navigationBar)
        }
    }
}
