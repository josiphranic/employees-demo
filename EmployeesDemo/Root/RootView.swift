//
//  RootView.swift
//  EmployeesDemo
//
//  Created by Josip Hranic on 01.11.2022..
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {

    @Environment(\.scenePhase) private var scenePhase
    let rootStore: StoreOf<RootReducer>

    var body: some View {
        WithViewStore(rootStore, observe: { $0 }) { rootViewStore in
            NavigationStack {
                ZStack {
                    VStack {
                        if let employees = rootViewStore.employees {
                            TeamListView(teamStore: rootStore.scope(state: { TeamFeature.State(palette: $0.themePallete,
                                                                                               teamViewModels: employees.teamViewModels,
                                                                                               teamSelected: nil,
                                                                                               themeType: $0.themeType) }).actionless)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.purple)
                        } else if rootViewStore.loadingState == .idle {
                            Spacer()
                            Text("👻 No data")
                                .shimmering()
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack {
                        switch rootViewStore.loadingState {
                        case .failed:
                            Text("❌ Loading failed")
                                .padding(60)
                                .shimmering()
                                .foregroundColor(rootViewStore.themePallete.primaryTextColor)
                            Spacer()
                        case .idle:
                            EmptyView()
                        case .loading:
                            Text("⌛ Loading...")
                                .padding(60)
                                .shimmering()
                                .foregroundColor(rootViewStore.themePallete.primaryTextColor)
                            Spacer()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(rootViewStore.themePallete.primaryBackgroundColor)
                .onChange(of: scenePhase) { phase in
                    if phase == .active {
                        rootViewStore.send(.appBecameActiv)
                    }
                }
                .navigationDestination(for: TeamViewModel.self) { teamViewModel in
                    TeamView(teamStore: rootStore.scope(state: { TeamFeature.State(palette: $0.themePallete,
                                                                                   teamViewModels: nil,
                                                                                   teamSelected: teamViewModel,
                                                                                   themeType: $0.themeType) },
                                                        action: { .teamAction($0) }))
                }
                .navigationTitle("Teltechians")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button("🔄") {
                                rootViewStore.send(.loadButtonTap)
                            }
                            .font(.system(size: 30))
                            switch rootViewStore.themeType {
                            case .light:
                                Button("🌚") {
                                    rootViewStore.send(.changeTheme)
                                }
                                .font(.system(size: 30))
                            case .dark:
                                Button("🌞") {
                                    rootViewStore.send(.changeTheme)
                                }
                                .font(.system(size: 30))
                            }
                        }
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(rootViewStore.themePallete.secondaryBackgroundColor, for: .navigationBar)
                .toolbarColorScheme(rootViewStore.themeType == .dark ? .dark : .light, for: .navigationBar)
            }
        }
    }
}

private extension Employees {

    var teamViewModels: [TeamViewModel] {
        [TeamViewModel(name: "Executive team", employees: executiveTeam),
         TeamViewModel(name: "Operations", employees: operations),
         TeamViewModel(name: "Product team", employees: productTeam),
         TeamViewModel(name: "Marketing team", employees: marketingTeam),
         TeamViewModel(name: "Design team", employees: designTeam),
         TeamViewModel(name: "Developement team", employees: developementTeam),
         TeamViewModel(name: "Data team", employees: dataTeam),
         TeamViewModel(name: "QA team", employees: qualityAssuranceTeam),
         TeamViewModel(name: "Customer service team", employees: customerServiceTeam)]
    }
}
