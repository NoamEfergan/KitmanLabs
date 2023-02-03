//
//  MainViewTests.swift
//  KitmanLabsTests
//
//  Created by Noam Efergan on 03/02/2023.
//

import XCTest
@testable import KitmanLabs
final class MainViewTests: XCTestCase {
    var vm: MainViewVM!
    override func setUpWithError() throws {
        vm = MainViewVM()
    }

    func testInitialValues() {
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.hasError)
    }
    
    
    func testMatchingAthletesWithSquads() throws {
        let test1 = "test1"
        let test2 = "test2"
        let test3 = "test3"
        let test4 = "test4"
        let athletes: [Athlete] = [
            .init(firstName: test1, lastName: test1, id: 1, image: .init(url: ""), username: test1, squadIDS: [1]),
            .init(firstName: test2, lastName: test2, id: 2, image: .init(url: ""), username: test2, squadIDS: [2]),
            .init(firstName: test3, lastName: test3, id: 3, image: .init(url: ""), username: test3, squadIDS: [3]),
            .init(firstName: test4, lastName: test4, id: 4, image: .init(url: ""), username: test4, squadIDS: [4]),
        ]
        let squads: [Squad] = [
            .init(createdAt: .empty, id: 1, name: test1, organisationID: 1, updatedAt: .empty),
            .init(createdAt: .empty, id: 2, name: test2, organisationID: 2, updatedAt: .empty),
            .init(createdAt: .empty, id: 3, name: test3, organisationID: 3, updatedAt: .empty),
            .init(createdAt: .empty, id: 4, name: test4, organisationID: 4, updatedAt: .empty)
        ]
        
        let matched = vm.matchAthletesWithSquads(athletes, squads)
        XCTAssertEqual(matched.keys.count, squads.count)
        for squad in matched.keys {
            let atKey = try XCTUnwrap(matched[squad])
            switch squad.id {
            case 1:
                XCTAssertEqual(squad.name, test1)
                XCTAssertEqual(atKey.first?.firstName, test1)
                XCTAssertFalse(atKey.isEmpty)
            case 2:
                XCTAssertEqual(squad.name, test2)
                XCTAssertEqual(atKey.first?.firstName, test2)
                XCTAssertFalse(atKey.isEmpty)
            case 3:
                XCTAssertEqual(squad.name, test3)
                XCTAssertEqual(atKey.first?.firstName, test3)
                XCTAssertFalse(atKey.isEmpty)
            case 4:
                XCTAssertEqual(squad.name, test4)
                XCTAssertEqual(atKey.first?.firstName, test4)
                XCTAssertFalse(atKey.isEmpty)
            default:
                XCTFail("Shouldn't hit this ever")
            }
        }
    }


}
