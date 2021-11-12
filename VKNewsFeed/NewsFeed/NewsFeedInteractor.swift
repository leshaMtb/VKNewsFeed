//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Apple on 04.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    switch request {

    case .some:
        print("some interactor")
    case .getFeed:
        print("interactor getFeed ")
        presenter?.presentData(response: .presentNewsFeed)
    }
  }


  
}
