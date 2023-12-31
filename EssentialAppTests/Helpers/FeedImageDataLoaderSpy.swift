//
//  FeedImageDataLoaderSpy.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import Foundation
import EssentialFeed

public class FeedImageDataLoaderSpy: FeedImageDataLoader {
    private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    private(set) var cancelledURLs = [URL]()
    
    var loadedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    private struct Task: FeedImageDataLoaderTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    public func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    public func complete(with data: Data, at index: Int = 0) {
        messages[index].completion(.success(data))
    }
}
