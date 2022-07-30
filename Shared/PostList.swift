//
//  PostList.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/20.
//

import SwiftUI

struct PostList: View {
    //    @State var posts = [Post]()
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading) {
                Text(post.title).font(.system(.title,design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
