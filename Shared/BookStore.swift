//
//  BookStore.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/20.
//

import SwiftUI
import Contentful
import Combine

// 访问预览api
let client = Client(spaceId: "xxh0h96z1rqy", accessToken: "ckRbWqRYLZhqDcqrcmV6cDTuwq0BHhsMIcmXBsFOu-c")


// entry是contentful的数据模型
func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            // 异步调用，让使用ui时可以接收数据
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

class BookStore: ObservableObject {
    @Published var books: [Book] = bookData
    
    // 用getArray进行contentful api call
    init() {
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                // 将Entry的数据模型转换成Book，因为swift不知道数据类型是什么，所以我们要用 as! String 指明数据类型
                self.books.append(Book(title: item.fields["title"] as! String,
                                       headline: item.fields["headline"] as! String,
                                       logo: item.fields["logo"] as! String,
                                       image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                                       color: colors.randomElement()!,
                                       showBookContent: false))
            }
        }
    }
}
