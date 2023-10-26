//
//  XCTest+trackingForMemoryLeaks.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-26.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been dealocated. Potencial memory leak", file: file, line: line)
        }
    }
}

