//
//  LoaderStub.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import EssentialFeed

public class LoaderStub: FeedLoader {
    private let result: FeedLoader.Result

    public init(result: FeedLoader.Result) {
        self.result = result
    }

    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
       completion(result)
    }
}
