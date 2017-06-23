//
//  YoutubeService.swift
//  Youtube Clone
//
//  Created by Vineeth Ravindra on 6/18/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation

class YoutubeService {
    static let apiManager = APIManager()
    
    class func getInfoDict(completion: @escaping (([YoutubeModel]) -> Void )) {
        performGet(url: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json",completion: completion)
    }
    
    class func getTrending(completion: @escaping (([YoutubeModel]) -> Void )) {
        performGet(url: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json",completion: completion)
    }
    
    class func getSubscriptions(completion: @escaping (([YoutubeModel]) -> Void )) {
        performGet(url: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscription.json",completion: completion)
    }
    
    class func performGet(url: String, completion: @escaping (([YoutubeModel]) -> Void )) {
        apiManager.performGetOn(url: url) {
            guard let result = $0["result"] as? [Any] else { return }
            let channels: [YoutubeModel] = result.map {
                guard let channel = $0 as? JSONDictType else {return nil}
                let model = YoutubeModel()
                model.loadDescriptionFromPayload(channel)
                return model
                }.flatMap({$0})
            completion(channels)
        }
    }
    
    
    class func downloadImage(link: String, completion: @escaping ((Data) -> Void )) {
        apiManager.performGetOn(url: link,downloadImage: true) {
            guard let result = $0["result"] as? Data else { return }
            completion(result)
        }
    }
    
    
}


