//
//  UpdateStore.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/2.
//

import SwiftUI
import Combine //允许我们创建储存，并进行数据操作的框架

class UpdateStore: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var updates: [Update] {
        //didSet是一个事件，当我们修改更新数据时，他会发送到储存(didChange)
        didSet {
            didChange.send()
        }
    }
    init(updates: [Update] = []) {
        self.updates = updates
    }
}
