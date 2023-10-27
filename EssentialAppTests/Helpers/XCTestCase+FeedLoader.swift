//
//  XCTestCase+FeedLoader.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import XCTest
import EssentialFeed

extension XCTestCase {
    func expect(_ sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result,file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait to load feed")
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedResult), .success(expectedResult)):
                XCTAssertEqual(receivedResult, expectedResult, file: file, line: line)
                break
            case (.failure, .failure):
                break
            default:
                XCTFail("Expected \(expectedResult), got instead \(receivedResult)", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}
