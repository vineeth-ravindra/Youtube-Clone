//
//  GetOperation.swift
//  Youtube Clone
//
//  Created by Vineeth Venugopal Ravindra on 6/20/17.
//  Copyright © 2017 Vineeth Ravindra. All rights reserved.
//

import Foundation

typealias WebCompletionType = ((JSONDictType) -> Void)

class GetOperation: AsyncOpeartion {
    
    let session = URLSession(configuration: .default)
    let request: URLRequest?
    var completion: WebCompletionType? = nil
    var downloadImage = false
    
    init(url: URL, completion: WebCompletionType?, contentcTypeHtml: Bool) {
        request = URLRequest(url: url)
        self.completion = completion
        downloadImage = contentcTypeHtml
        super.init()
    }
    
    override func main() {
        guard let request = request else { return }
        session.dataTask(with: request) {[weak self] data, response, error in
            var result: JSONDictType?
            guard let slf = self , let completion = slf.completion else { return }
            if error != nil {
                print("There was a error fetching data on request \(String(describing: request.url))")
                print( "\n Error was \(error?.localizedDescription ?? " " )" )
                result = ["result" : error as Any]
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data {
                    if slf.downloadImage == true {
                        result = ["result" : data as Any]
                    } else {
                        do {
                            let res = try JSONSerialization.jsonObject(with: data, options: [])
                            result = ["result" : res]
                        } catch let exception {
                            print("Unable to deserialize data \(exception.localizedDescription)")
                            result = ["result" : exception as Any]
                        }
                    }
                } else {
                    let error =  NSError(domain: "HTTP Request Error", code: response.statusCode, userInfo:  ["error": "HTTP Error"])
                    result = ["result" : error]
                }
            }
            if let result = result {
                completion(result)
            }
            self?.state = .finished
            }.resume()
    }
    
}
