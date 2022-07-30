//
//  EnvironmentStore.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/24.
//

import SwiftUI
import Combine

// 环境变量
class EnvironmentStore: ObservableObject {
    // home页的顶部菜单栏的隐藏状态
    @Published var hide = false
}
