//
//  Shared+UniqueFuncsHelpers.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-27.
//

import EssentialFeed

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "anyDescription", location: "anyLocation", url: anyURL())]
}
