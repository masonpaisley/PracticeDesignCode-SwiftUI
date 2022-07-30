//
//  DataStore.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/20.
//

import SwiftUI
import Combine
// combine使数据可以不断更新

class DataStore: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
