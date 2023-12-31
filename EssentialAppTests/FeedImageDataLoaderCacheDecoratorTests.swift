//
//  FeedImageDataLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//
// No need of this test anymore
//import XCTest
//import EssentialFeed
//import EssentialApp
//
//final class FeedImageDataLoaderCacheDecoratorTests: XCTestCase, FeedImageDataLoaderTestCase {
//    
//    func test_init_doesNotLoadImageData() {
//        let (_, loader) = makeSUT()
//        
//        XCTAssertTrue(loader.loadedURLs.isEmpty, "Expected no loaded URLs")
//    }
//    
//    func test_loadImageData_loadsFromLoader() {
//        let url = anyURL()
//        let (sut, loader) = makeSUT()
//        
//        _ = sut.loadImageData(from: url) { _ in }
//        
//        XCTAssertEqual(loader.loadedURLs, [url], "Expected to load URL from loader")
//    }
//    
//    func test_cancelLoadImageData_cancelsLoaderTask() {
//        let url = anyURL()
//        let (sut, loader) = makeSUT()
//        
//        let task = sut.loadImageData(from: url) { _ in }
//        task.cancel()
//        
//        XCTAssertEqual(loader.cancelledURLs, [url], "Expected to cancel URL loading from loader")
//    }
//    
//    func test_loadImageData_deliversDataOnLoaderSuccess() {
//        let imageData = anyData()
//        let (sut, loader) = makeSUT()
//        
//        expect(sut, toCompleteWith: .success(imageData), when: {
//            loader.complete(with: imageData)
//        })
//    }
//    
//    func test_loadImageData_deliversErrorOnLoaderFailure() {
//        let (sut, loader) = makeSUT()
//        
//        expect(sut, toCompleteWith: .failure(anyNSError()), when: {
//            loader.complete(with: anyNSError())
//        })
//    }
//    
//    func test_loadImageData_cachesLoadedDataOnLoaderSuccess() {
//        let cache = CacheSpy()
//        let data = anyData()
//        let url = anyURL()
//        let (sut, loader) = makeSUT(cache: cache)
//        _ = sut.loadImageData(from: url) { _ in }
//        loader.complete(with: data)
//        XCTAssertEqual(cache.messages, [.save(data: data, for: url)])
//    }
//    
//    func test_loadImageData_doesNotCacheDataOnLoaderFailure() {
//        let cache = CacheSpy()
//        let url = anyURL()
//        let (sut, loader) = makeSUT(cache: cache)
//        
//        _ = sut.loadImageData(from: url) { _ in }
//        loader.complete(with: anyNSError())
//        
//        XCTAssertTrue(cache.messages.isEmpty, "Expected not to cache image data on load error")
//    }
//    
//    // MARK: Helpers
//    
//    private func makeSUT(cache: CacheSpy = .init(), file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImageDataLoaderCacheDecorator, FeedImageDataLoaderSpy) {
//        let loader = FeedImageDataLoaderSpy()
//        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader, cache: cache)
//        trackForMemoryLeaks(loader, file: file, line: line)
//        trackForMemoryLeaks(sut, file: file, line: line)
//        return (sut, loader)
//    }
//    
//    private class CacheSpy: FeedDataImageCache {
//        enum Message: Equatable {
//            case save(data: Data, for: URL)
//        }
//        
//        private(set) var messages = [Message]()
//        
//        func save(_ data: Data, for url: URL, completion: @escaping (FeedDataImageCache.Result) -> Void) {
//            messages.append(.save(data: data, for: url))
//            completion(.success(()))
//        }
//    }
//    
//}
