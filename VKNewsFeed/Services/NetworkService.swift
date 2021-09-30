//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Apple on 30.09.2021.
//

import Foundation

final class NetworkService {

    private let authService: AuthorizationService

    init(authService: AuthorizationService = SceneDelegate.shared().authorizationService) {
        self.authService = authService
    }

    func getFeed() {
        print("нихуя себе 1")

        guard let token = authService.token else {
            print("нихуя себе 2")
       return
        }
        let param = ["filter":"post,photo"]
        var allParams = param
        allParams["access_token"] = token
        allParams["v"] = API.version
        print(allParams)
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allParams.map{URLQueryItem(name: $0, value: $1)}
        let url = components.url
        print(url!)
        
    }
}
