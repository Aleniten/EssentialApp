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
            let primaryLoader = LoaderStub(result: primaryResult)
            let fallbackLoader = LoaderStub(result: fallbackResult)
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
    
        func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(instance, "Instance should have been dealocated. Potencial memory leak", file: file, line: line)
            }
        }
    
        private func uniqueFeed() -> [FeedImage] {
            return [FeedImage(id: UUID(), description: "anyDescription", location: "anyLocation", url: anyURL())]
        }
    
        private func anyURL() -> URL {
            return URL(string: "https://any-url.com")!
        }
    
        func anyNSError() -> NSError {
            return NSError(domain: "any error", code: 1)
        }
    
        private class LoaderStub: FeedLoader {
            private let result: FeedLoader.Result
    
            init(result: FeedLoader.Result) {
                self.result = result
            }
    
            func load(completion: @escaping (FeedLoader.Result) -> Void) {
               completion(result)
            }
        }
}
