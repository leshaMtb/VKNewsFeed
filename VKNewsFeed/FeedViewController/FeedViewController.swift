//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Apple on 30.09.2021.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        fetcher.getFeed { (feedResponse) in
            guard let feedResponce1 = feedResponse else { return }
            feedResponce1.items.map({ (feedItem)  in
                print(feedItem.date)
            })

        }

    }




    
}
