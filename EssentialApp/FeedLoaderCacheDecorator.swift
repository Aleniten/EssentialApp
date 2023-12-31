//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Jose Herrero on 2023-10-27.
//

// Replaced with Combine
//import EssentialFeed
//
//public final class FeedLoaderCacheDecorator: FeedLoader {
//    private let decoratee: FeedLoader
//    private let cache: FeedCache
//    
//    public init(decoratee: FeedLoader, cache: FeedCache) {
//        self.decoratee = decoratee
//        self.cache = cache
//    }
//    
//    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
//        decoratee.load { [weak self] result in
//            completion(result.map { feed in
//                self?.cache.savesIgnoresResult(feed)
//                return feed
//            })
//        }
//    }
//}
//
