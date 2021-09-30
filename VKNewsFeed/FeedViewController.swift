//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Apple on 30.09.2021.
//

import UIKit

class FeedViewController: UIViewController {


    private let networkService = NetworkService()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
       networkService.getFeed()
    }




    
}
