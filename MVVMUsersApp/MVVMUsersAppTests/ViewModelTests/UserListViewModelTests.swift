//
//  UserListViewModelTests.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


import XCTest
@testable import MVVMUsersApp

final class UserListViewModelTests: XCTestCase {

    var viewModel: UserListViewModel!
    var mockAPI: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockAPI = MockAPIClient()
        viewModel = UserListViewModel(apiClient: mockAPI)
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        mockAPI.mockUsers = [
            User(id: 1,
                name: "Test User",
                username: "testuser",
                email: "test@mail.com",
                phone: "123-456-789",
                website: "example.com",
                company: User.Company(name: "TestCo", catchPhrase: "Test Phrase", bs: "TestBS")
            )
        ]

        let expectation = self.expectation(description: "Data loaded")
        viewModel.onDataUpdate = { expectation.fulfill() }
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.numberOfRows(), 1)
    }

    func testFetchUsersFailure() {
        mockAPI.shouldFail = true

        let expectation = self.expectation(description: "Error received")
        viewModel.onError = { message in
            XCTAssertNotNil(message)
            expectation.fulfill()
        }
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 1)
    }
}
