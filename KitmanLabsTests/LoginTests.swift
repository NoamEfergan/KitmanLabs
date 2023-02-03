//
//  LoginTests.swift
//  KitmanLabsTests
//
//  Created by Noam Efergan on 03/02/2023.
//

import XCTest
@testable import KitmanLabs
final class LoginTests: XCTestCase {
    var vm: LoginViewModel!
    override func setUpWithError() throws {
        vm = LoginViewModel()
    }
    
    func testInitialValues() {
        XCTAssertEqual(vm.userName, .empty)
        XCTAssertEqual(vm.password, .empty)
        XCTAssertFalse(vm.hasGeneralError)
        XCTAssertFalse(vm.hasUsernameError)
        XCTAssertFalse(vm.hasPasswordError)
    }
    
    func testValidUsername() async {
        vm.userName = .empty
        vm.password = "1234"
        var login = await vm.performLogin()
        XCTAssertFalse(login)
        XCTAssert(vm.hasUsernameError)
        vm.userName = "test"
        login = await vm.performLogin()
        XCTAssert(login)
        XCTAssertFalse(vm.hasUsernameError)
    }
    
    func testValidPassword() async {
        vm.password = .empty
        vm.userName = "1234"
        var login = await vm.performLogin()
        XCTAssertFalse(login)
        XCTAssert(vm.hasPasswordError)
        vm.password = "test"
        login = await vm.performLogin()
        XCTAssert(login)
        XCTAssertFalse(vm.hasPasswordError)
    }
}
