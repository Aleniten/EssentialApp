//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import XCTest
import EssentialFeed

final class FeedLoaderCacheDecorator: FeedLoader {
    let decoratee: FeedLoader
    
    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: completion)
    }
}

final class FeedLoaderCacheDecoratorTests: XCTestCase {

    func test_load_deliversFeedOnLoaderSuccess() throws {
        let feed = uniqueFeed()
        let loader = FeedLoaderStub(result: .success(feed))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .success(feed))
    }
    
    func test_load_deliversErrorOnLoaderFailure() throws {
        let loader = FeedLoaderStub(result: .failure(anyNSError()))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    // MARK: Helpers
    
    private func expect(_ sut: FeedLoaderCacheDecorator, toCompleteWith expectedResult: FeedLoader.Result, file: StaticString = #filePath, line: UInt = #line) {
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
