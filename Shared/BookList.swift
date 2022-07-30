//
//  BookList.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookList: View {
//    @State var books = bookData
    @ObservedObject var store = BookStore()
    @State var hideStatus = false
    @State var activeIndex = -1
    
    var body: some View {
        ZStack {
//            Color.black.opacity(hideStatus ? 0.5 : 0)
//                .animation(.easeIn)
//                .ignoresSafeArea()
            
            // 因为home有ScrollView了，重叠会出问题，所以这里我改成了vstack
            VStack {
                VStack(spacing: 30.0) {
                    Text("最爱的书")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.leading, 28)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .blur(radius: hideStatus ? 20 : 0)
                    
                    // 根据bookData数量自动增加书籍卡片，以及填充卡片内容
                    ForEach(store.books.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            BookView(
                                showBookContent: $store.books[index].showBookContent,
                                hideStatus: $hideStatus,
                                index: index,
                                activeIndex: $activeIndex,
                                books: store.books[index]
                            )
                            .offset(y: store.books[index].showBookContent ? -geometry.frame(in: .global).minY : 0)
                            .opacity(activeIndex != index && hideStatus ? 0 : 1)
                            .scaleEffect(activeIndex != index && hideStatus ? 0.5 : 1)
                            .offset(x: activeIndex != index && hideStatus ? UIScreen.main.bounds.width : 0)
                        }
                        .frame(height: store.books[index].showBookContent ? UIScreen.main.bounds.height : 280)
                        .frame(maxWidth: store.books[index].showBookContent ? .infinity : UIScreen.main.bounds.width-60)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            //            rotationEffect(.zero, anchor: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            //隐藏状态栏
            .statusBar(hidden: hideStatus ? true : false)
            .animation(.default)
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
            .previewDevice("iPhone 11 Pro")
            .environmentObject(EnvironmentStore())
    }
}

struct BookView: View {
    @Binding var showBookContent: Bool
    @EnvironmentObject var hideButton: EnvironmentStore
    @Binding var hideStatus: Bool
    // 我也不懂下面2个参数是干什么、以及怎么用的。。。
    var index: Int
    @Binding var activeIndex: Int
    @State var activeBook = CGSize.zero
    var books: Book
    
    var body: some View {
        ZStack(alignment: .top) {
            // 笔记内容放在卡片后面，并限制宽高，点击卡片后从下方展开并移出
//            VStack(alignment: .leading, spacing: 20) {
//                Text("宇宙可能是有个目的，即使如此，我们所知道的一切也不能说明它的目的和我们的目的有任何相似之处。")
//            }
//            .padding(30)
//            .padding(.top, 40)
//            .frame(maxWidth: showBookContent ? .infinity : UIScreen.main.bounds.width-60, maxHeight: showBookContent ? .infinity : 280, alignment: .top)
//            .background(Color.white)
//            //            .cornerRadius(30)
//            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .shadow(color: .blue.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
//            .offset(y: showBookContent ? 440 : 0)
//            .opacity(showBookContent ? 1.0 : 0)
            
            // 卡片视图点击后展开
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
                        .opacity(showBookContent ? 1.0 : 0.8)
//                        .onTapGesture {
//                            self.showBookContent.toggle()
//                            self.hideStatus.toggle()
//                            self.activeIndex = -1
//                        }
                }
                .padding(showBookContent ? 30 : 20)
                .padding(.top, showBookContent ? 30 : 8)
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
            //拖动缩放到50，关闭bookView
//            .gesture(
//                showBookContent ?
//                DragGesture().onChanged { value in
//                    // 滑动退出时，当value.translation.height大于300，直接退出，并且防止向上滑动时，产生的放大效果
//                    guard value.translation.height < 300 else { return }
//                    guard value.translation.height > 0 else { return }
//                    // 禁用拖动缩小并关闭
//                    //                        self.activeBook = value.translation
//                }
//                    .onEnded { value in
//                        if self.activeBook.height > 50 {
//                            self.showBookContent = false
//                            self.hideStatus = false
//                            self.activeIndex = -1
//                        }
//                        self.activeBook = .zero
//                    }
//                : nil
//            )
            .onTapGesture {
                self.showBookContent = true
                self.hideStatus = true
                self.hideButton.hide = true
                // 教程里没有汉化，不知道啥意思，
                if self.showBookContent {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
            // 原卡片展开后，滑动会导致其他的卡片显示出来，调用另一个相同的独立页面，覆盖上去，使其可以滚动查看
            if showBookContent {
                BookDetail(books: books, showBookContent: $showBookContent, hideStatus: $hideStatus, activeIndex: $activeIndex)
                    .background(Color.white)
                    .animation(nil)
            }
        }
        .scaleEffect(1 - self.activeBook.height/1000)
        .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0))
        .ignoresSafeArea(.all)
    }
}

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var logo: String
    var image: URL
    var color: UIColor
    var showBookContent: Bool
}

let bookData = [
    Book(title: "幸福之路",
         headline: "这张卡片没有调用api，是本地的，图片是notion库的链接",
         logo: "books.vertical",
         image: URL(string: "https://masonwang.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F32169ae3-fae3-4f9b-afdb-bed874681869%2FUntitled.png?table=block&id=8732f54b-b8b6-4114-ada1-4fd801807133&spaceId=0f631e10-152d-429a-a448-e31eb1de9743&width=2880&userId=&cache=v2")!,
         color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
         showBookContent: false
    )
//    Book(title: "天生有罪",
//         headline: "11个笔记",
//         logo: "books.vertical",
//         image: "404_1",
//         color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
//         showBookContent: false
//    )
]
 
