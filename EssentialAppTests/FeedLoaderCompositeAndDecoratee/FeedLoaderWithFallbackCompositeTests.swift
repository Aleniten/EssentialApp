//
//  FeedLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-26.
//

import XCTest
import EssentialFeed
import EssentialApp

final class FeedLoaderWithFallbackCompositeTests: XCTestCase {
    
        func test_load_deliversPrimaryFeedOnPrimaryLoaderSuccess() {
            let primaryFeed = uniqueFeed()
            let fallbackFeed = uniqueFeed()
            let sut = makeSUT(primaryResult: .success(primaryFeed), fallbackResult: .success(fallbackFeed))
    
            expect(sut, toCompleteWith: .success(primaryFeed))
        }
    
        func test_load_deliversFallbackFeedOnPrimaryFailure() {
            let fallbackFeed = uniqueFeed()
            let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackFeed))
    
            expect(sut, toCompleteWith: .success(fallbackFeed))
        }
    
        func test_load_deliversErrorOnBothPrimaryAndFallbackLoaderFailure() {
            let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))
    
            expect(sut, toCompleteWith: .failure(anyNSError()))
        }
    
        // MARK: Helper
    
        private func makeSUT(primaryResult: FeedLoader.Result, fallbackResult: FeedLoader.Result,file: StaticString = #filePath, line: UInt = #line) -> FeedLoader {
            let primaryLoader = FeedLoaderStub(result: primaryResult)
            let fallbackLoader = FeedLoaderStub(result: fallbackResult)
            let sut = FeedLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
            trackForMemoryLeaks(primaryLoader, file: file, line: line)
            trackForMemoryLeaks(fallbackLoader, file: file, line: line)
            trackForMemoryLeaks(sut, file: file, line: line)
            return sut
        }
    
        private func expect(_ sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result,file: StaticString = #filePath, line: UInt = #line) {
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
