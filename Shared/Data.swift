//
//  Data.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/19.
//


import SwiftUI

struct Post: Codable,Identifiable {
    var id: Int
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return}
            
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                completion(posts)
            }
        }.resume()
    }
}
