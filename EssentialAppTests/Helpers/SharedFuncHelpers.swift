//
//  SharedFuncHelpers.swift
//  EssentialAppTests
//
//  Created by Jose Herrero on 2023-10-26.
//

import Foundation
import EssentialFeed

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}
