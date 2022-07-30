//
//  BookDetail.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetail: View {
    var books: Book
    @Binding var showBookContent: Bool
    @Binding var hideStatus: Bool
    @Binding var activeIndex: Int
    @EnvironmentObject var hideButton: EnvironmentStore
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        // 标题和副标题
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(books.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .lineLimit(2)
                            Text(books.headline)
                                .font(.headline)
                                .foregroundColor(.black.opacity(0.8))
                                .lineLimit(2)
                        }
                        Spacer()
                        // icon默认是书，展开后变成关闭按钮
                        Image(systemName: showBookContent ? "xmark" : books.logo)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.showBookContent = false
                                self.hideStatus = false
                                self.hideButton.hide = false
                                self.activeIndex = -1
                            }
                    }
                    .padding(showBookContent ? 30 : 20)
                    .padding(.top, showBookContent ? 30 : 8)
                    //                Spacer()
                    WebImage(url: books.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //                    .frame(height: 140)
                        .padding(.bottom)
                }
                .frame(maxWidth: showBookContent ? .infinity : UIScreen.main.bounds.width-60, maxHeight: showBookContent ? 480 : 280)
                .background(Color(books.color))
                .cornerRadius(30)
                .shadow(color: Color(books.color).opacity(0.2), radius: 20, x: 0.0, y: 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("宇宙可能是有个目的，即使如此，我们所知道的一切也不能说明它的目的和我们的目的有任何相似之处。")
                    Text("爱情只有当它是自由自在时，才会叶茂花繁。认为爱情是某种义务的思想只能置爱情于死地。只消一句话：你应当爱某个人，就足以使你对这个人恨之入骨")
                    Text("对爱情的渴望，对知识的追求，对人类苦难不可遏制的同情心，这三种纯洁而无比强烈的激情支配着我的一生。这三种激情，就像飓风一样，在深深的苦海上，肆意地把我吹来吹去，吹到濒临绝望的边缘")
                    Text("对爱情的渴望，对知识的追求，对人类苦难不可遏制的同情心，这三种纯洁而无比强烈的激情支配着我的一生。这三种激情，就像飓风一样，在深深的苦海上，肆意地把我吹来吹去，吹到濒临绝望的边缘")
                }
                .padding(30)
            }
        }
        .ignoresSafeArea()
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(books: bookData[0], showBookContent: .constant(true), hideStatus: .constant(true), activeIndex: .constant(-1))
    }
}

