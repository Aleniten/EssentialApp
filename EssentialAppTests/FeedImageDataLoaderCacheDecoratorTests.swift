//
//  FeedImageDataLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import XCTest
import EssentialFeed

final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    let decoratee: FeedImageDataLoader
    
    init(decoratee: FeedImageDataLoader) {
        self.decoratee = decoratee
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url, completion: completion)
    }
}

final class FeedImageDataLoaderCacheDecoratorTests: XCTestCase, FeedImageDataLoaderTestCase {
    
    func test_init_doesNotLoadImageData() {
            let (_, loader) = makeSUT()

            XCTAssertTrue(loader.loadedURLs.isEmpty, "Expected no loaded URLs")
        }

        func test_loadImageData_loadsFromLoader() {
            let url = anyURL()
            let (sut, loader) = makeSUT()

            _ = sut.loadImageData(from: url) { _ in }

            XCTAssertEqual(loader.loadedURLs, [url], "Expected to load URL from loader")
        }

        func test_cancelLoadImageData_cancelsLoaderTask() {
            let url = anyURL()
            let (sut, loader) = makeSUT()

            let task = sut.loadImageData(from: url) { _ in }
            task.cancel()

            XCTAssertEqual(loader.cancelledURLs, [url], "Expected to cancel URL loading from loader")
        }

        func test_loadImageData_deliversDataOnLoaderSuccess() {
            let imageData = anyData()
            let (sut, loader) = makeSUT()

            expect(sut, toCompleteWith: .success(imageData), when: {
                loader.complete(with: imageData)
            })
        }

        func test_loadImageData_deliversErrorOnLoaderFailure() {
            let (sut, loader) = makeSUT()

            expect(sut, toCompleteWith: .failure(anyNSError()), when: {
                loader.complete(with: anyNSError())
            })
        }
    // MARK: Helpers
    
    private func makeSUT(cache: CacheSpy = .init(), file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImageDataLoaderCacheDecorator, FeedImageDataLoaderSpy) {
        let loader = FeedImageDataLoaderSpy()
        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    
}
