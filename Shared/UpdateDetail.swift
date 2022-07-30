//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/2.
//

import SwiftUI

struct UpdateDetail: View {
    var title = ""
    var text = ""
    var image = ""
    
    var body: some View {
        VStack(spacing: 20.0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height:200)
            Text(text)
                .lineLimit(nil)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
