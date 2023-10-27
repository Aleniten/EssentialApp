//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Jose Herrero on 2023-10-27.
//

import Foundation
import EssentialFeed

public final class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: FeedCache
    
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            completion(result.map { feed in
                self?.savesIgnoresResult(feed)
                return feed
            })
        }
    }
}

private extension FeedLoaderCacheDecorator {
    func savesIgnoresResult(_ feed: [FeedImage]) {
        cache.save(feed) { _ in }
    }
}
