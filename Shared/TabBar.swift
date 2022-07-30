//
//  TabBar.swift
//  TabBar
//
//  Created by jinzhao wang on 2021/9/5.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        //底部导航栏，默认第一个
        TabView {
            Home() .tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("首页")
                }
            }
            .tag(1)
            ContentView() .tabItem {
                VStack {
                    Image(systemName: "doc.plaintext")
                    Text("书单")
                }
            }
            .tag(2)
            Setting() .tabItem {
                VStack {
                    Image(systemName: "icloud.and.arrow.up")
                    Text("设置")
                }
            }
            .tag(3)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
            TabBar()
//            TabBar()
//                .environment(\.colorScheme, .dark)
//                .environment(\.sizeCategory, .extraLarge)
            .environmentObject(EnvironmentStore())
    }
}

