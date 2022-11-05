//
//  EmployeesDemoTests.swift
//  EmployeesDemoTests
//
//  Created by Josip Hranic on 05.11.2022..
//

import XCTest
@testable import EmployeesDemo
import ComposableArchitecture

//Test cases that use TestStore should be annotated as @MainActor and test methods should be marked as async since most assertion helpers on TestStore can suspend.
@MainActor
final class EmployeesDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRootThemeChange() async throws {
        let tempThemeService = ThemeService()
        tempThemeService.updateTheme(type: .dark)
        let darkPallete = tempThemeService.getPalette()
        tempThemeService.updateTheme(type: .light)
        let lightPallete = tempThemeService.getPalette()
        let themeService = ThemeService()
        let rootReducer = RootReducer(apiClient: APIClientMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertEqual(store.state.themeType, .dark)
        await store.send(.changeTheme) {
            $0.themeType = .light
            $0.themePallete = lightPallete
        }
        await store.send(.changeTheme) {
            $0.themeType = .dark
            $0.themePallete = darkPallete
        }
    }

    func testAppBecomaActivDataLoading() async throws {
        let themeService = ThemeService()
        let apiClientMock = APIClientMock()
        let rootReducer = RootReducer(apiClient: APIClientMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertNil(store.state.teamSelected)
        XCTAssertNil(store.state.employees)
        XCTAssertEqual(store.state.loadingState, .idle)
        await store.send(.appBecameActiv) {
            $0.loadingState = .loading
        }
        await store.receive(.loaded(apiClientMock.getMockEmployees())) { [apiClientMock] in
            $0.loadingState = .idle
            $0.employees = apiClientMock.getMockEmployees()
        }
    }

    func testAppBecomaActivDataLoadingFail() async throws {
        let themeService = ThemeService()
        let rootReducer = RootReducer(apiClient: APIClientFailedMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertNil(store.state.teamSelected)
        XCTAssertNil(store.state.employees)
        XCTAssertEqual(store.state.loadingState, .idle)
        await store.send(.appBecameActiv) {
            $0.loadingState = .loading
        }
        await store.receive(.loadingFailed) {
            $0.loadingState = .failed
        }
    }

    func testLoadDataButtonTap() async throws {
        let themeService = ThemeService()
        let apiClientMock = APIClientMock()
        let rootReducer = RootReducer(apiClient: APIClientMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertNil(store.state.teamSelected)
        XCTAssertNil(store.state.employees)
        XCTAssertEqual(store.state.loadingState, .idle)
        await store.send(.loadButtonTap) {
            $0.loadingState = .loading
        }
        await store.receive(.loaded(apiClientMock.getMockEmployees())) { [apiClientMock] in
            $0.loadingState = .idle
            $0.employees = apiClientMock.getMockEmployees()
        }
    }

    func testLoadingButtonTapFailedLoading() async throws {
        let themeService = ThemeService()
        let rootReducer = RootReducer(apiClient: APIClientFailedMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertNil(store.state.teamSelected)
        XCTAssertNil(store.state.employees)
        XCTAssertEqual(store.state.loadingState, .idle)
        await store.send(.loadButtonTap) {
            $0.loadingState = .loading
        }
        await store.receive(.loadingFailed) {
            $0.loadingState = .failed
        }
    }

    func testTeamThemeChange() async throws {
        let tempThemeService = ThemeService()
        tempThemeService.updateTheme(type: .dark)
        let darkPallete = tempThemeService.getPalette()
        tempThemeService.updateTheme(type: .light)
        let lightPallete = tempThemeService.getPalette()
        let themeService = ThemeService()
        let rootReducer = RootReducer(apiClient: APIClientMock(),
                                      themeService: themeService,
                                      analyticsServiceType: AnalyticsServiceMock())
        let initialState = RootReducer.State(themePallete: themeService.getPalette(),
                                             themeType: themeService.themeType)

        let store = TestStore(initialState: initialState,
                              reducer: rootReducer)
        XCTAssertEqual(store.state.themeType, .dark)
        await store.send(.teamAction(.changeTheme)) {
            $0.themeType = .light
            $0.themePallete = lightPallete
        }
        await store.send(.changeTheme) {
            $0.themeType = .dark
            $0.themePallete = darkPallete
        }
        await store.send(.teamAction(.changeTheme)) {
            $0.themeType = .light
            $0.themePallete = lightPallete
        }
    }
}
