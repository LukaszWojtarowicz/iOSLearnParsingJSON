//
//  NetworkRequests.swift
//  InformationJsonApp
//
//  Created by  Łukasz Wojtarowicz on 19.02.2018.
//  Copyright © 2018  Łukasz Wojtarowicz. All rights reserved.
//

import Foundation

typealias APIPostsCompletionBlock = ((_ success: Bool, _ post: [Post]?) -> Void)

final class NetworkRequest {
    
    struct Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com/posts"
    }
    
    static func fetchPost(completion: @escaping APIPostsCompletionBlock) {
        guard let url = URL(string: Constants.baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data  else { return }
            do {
                completion(true, try JSONDecoder().decode([Post].self, from: data))
            } catch {
                completion(false, nil)
            }
            }.resume()
    }
    
}
