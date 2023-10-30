//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by Jose Herrero on 2023-10-30.
//

import XCTest

final class EssentialAppUIAcceptanceTests: XCTestCase {

    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()
        
        app.launch()
        
        XCTAssertEqual(app.cells.count, 22)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(app.cells.firstMatch.images.count, 1)
        }
    }
}
