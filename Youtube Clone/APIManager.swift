//
//  APIManager.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/20/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation

class APIManager {
    
    private let queue = OperationQueue()
    var downloadsSession: URLSession!
    
    func performGetOn(url: String, downloadImage: Bool = false, completion: @escaping WebCompletionType) {
//        queue.cancelAllOperations()
        // create QueryOperation
        if let url = URL(string: url) {
            let op = GetOperation(url: url, completion : completion, contentcTypeHtml: downloadImage)
            queue.addOperation(op)
        }
    }
    
}
