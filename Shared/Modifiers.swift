//
//  Modifiers.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/14.
//

import SwiftUI

//自定义阴影修饰符
struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 8)
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

//自定义字体修饰符
struct Font: ViewModifier {
//    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
    }
}

//自定义字体
struct NotoFont: ViewModifier {
    var size: CGFloat = 28
    
    func body(content: Content) -> some View {
        content.font(.custom("NotoSansSC-Bold", size: size))
    }
}
