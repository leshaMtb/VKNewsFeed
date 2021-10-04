//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Apple on 04.10.2021.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?)-> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        networking.request(path: API.newsFeed, params: ["filters": "photo,post"]) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                print("ошибочка")
            }
            let decoded = self.decodeJson(type: FeedResponseWrapped.self, from: data)
            //передаем респонсе в escaping блок
            response(decoded?.response)
        }
    }
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?)-> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from ,let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}



