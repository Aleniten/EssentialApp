//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Jose Herrero on 2023-10-27.
//

// Replaced with Combine
//import EssentialFeed
//
//public final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
//    private let decoratee: FeedImageDataLoader
//    private let cache: FeedDataImageCache
//    
//    public init(decoratee: FeedImageDataLoader, cache: FeedDataImageCache) {
//        self.decoratee = decoratee
//        self.cache = cache
//    }
//    
//    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
//        return decoratee.loadImageData(from: url) { [weak self] result in
//            completion(result.map { data in
//                self?.saveCacheIgnoresResult(data, url: url)
//                return data
//            })
//        }
//    }
//}
