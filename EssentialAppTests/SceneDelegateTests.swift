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

    func test_configureWindow_setsWindowAsKeyAndVisible() {
        let window = UIWindowSpy()
        let sut = SceneDelegate()
        sut.window = window
        
        sut.configureWindow()
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1, "Expected to make window key and visible")
    }
    
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

private class UIWindowSpy: UIWindow {
  var makeKeyAndVisibleCallCount = 0
  override func makeKeyAndVisible() {
    makeKeyAndVisibleCallCount = 1
  }
}
