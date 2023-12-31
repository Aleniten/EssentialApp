//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

// No need of this test anymore
//import XCTest
//import EssentialFeed
//import EssentialApp
//
//final class FeedLoaderCacheDecoratorTests: XCTestCase, FeedLoaderTestCase {
//
//    func test_load_deliversFeedOnLoaderSuccess() throws {
//        let feed = uniqueFeed()
//        let sut = makeSUT(loaderResult: .success(feed))
//        
//        expect(sut, toCompleteWith: .success(feed))
//    }
//    
//    func test_load_deliversErrorOnLoaderFailure() throws {
//        let sut = makeSUT(loaderResult: .failure(anyNSError()))
//        
//        expect(sut, toCompleteWith: .failure(anyNSError()))
//    }
//    
//    func test_load_cachesLoadedFeedOnLoaderSuccess() {
//        let cache = CacheSpy()
//        let feed = uniqueFeed()
//        let sut = makeSUT(loaderResult: .success(feed), cache: cache)
//       
//        sut.load { _ in }
//        
//        XCTAssertEqual(cache.messages, [.save(feed)], "Expected to cache load feed on Success")
//    }
//    
//    func test_load_doesNotcachesOnLoaderFailure() {
//        let cache = CacheSpy()
//        let sut = makeSUT(loaderResult: .failure(anyNSError()), cache: cache)
//      
//        sut.load { _ in }
//        
//        XCTAssertTrue(cache.messages.isEmpty, "Expected an empty cache on Failure")
//    }
//    
//    // MARK: Helpers
//    
//    private func makeSUT(loaderResult: FeedLoader.Result, cache: CacheSpy = .init(), file: StaticString = #filePath, line: UInt = #line) -> FeedLoaderCacheDecorator {
//        let loader = FeedLoaderStub(result: loaderResult)
//        let sut = FeedLoaderCacheDecorator(decoratee: loader, cache: cache)
//        trackForMemoryLeaks(loader, file: file, line: line)
//        trackForMemoryLeaks(sut, file: file, line: line)
//        return sut
//    }
//    
//    private class CacheSpy: FeedCache {
//        enum Message: Equatable {
//            case save([FeedImage])
//        }
//        
//        private(set) var messages = [Message]()
//        
//        func save(_ feed: [FeedImage], completion: @escaping (FeedCache.Result) -> Void) {
//            messages.append(.save(feed))
//            completion(.success(()))
//        }
//    }
//}
