//
//  SceneDelegateTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-31.
//

import XCTest
@testable import EssentialApp
import EssentialFeediOS

final class SceneDelegateTests: XCTestCase {

    func test_sceneWillConnectToSession_configureRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected  navigation controller as root, got instead \(String(describing: root))")
        XCTAssertTrue(topController is FeedViewController, "Expected a FeedViewController as a topController, got instead \(String(describing: topController))")
    }
}
