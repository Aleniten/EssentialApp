//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by Jose Herrero on 2023-10-26.
//

import UIKit
import CoreData
import EssentialFeed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let remoteUrl = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        let remoteClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let remoteFeedLoader = RemoteFeedLoader(url: remoteUrl, client: remoteClient)
        let remoteImageLoader = RemoteFeedImageDataLoader(client: remoteClient)
        
        let localStoreURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite")
        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
        
        window?.rootViewController = FeedUIComposer.feedComposedWith(
            feedLoader: remoteFeedLoader,
            imageLoader: remoteImageLoader)
    }

}

