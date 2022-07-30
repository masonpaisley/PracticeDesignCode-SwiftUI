//
//  UpdateList.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/1.
//

import SwiftUI

struct UpdateList: View {
    @State var showSetting = false
    //        var Update = updateData
    //观测对象修饰器，能够自动更新数据
    @ObservedObject var store = UpdateStore(updates: updateData)
    
    func addUpdate() {
        store.updates.append(Update(image: "Certificate1", title: "New TItle", text: "New TExt", date: "09/02"))
    }
    
    func move(from source: IndexSet, to destination: Int) {
        store.updates.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView {
            //尝试不使用navigationBar失败
            //因为删了NavigationView的话，NavigationLink就会失效
            //            VStack {
            //                HStack {
            //                    Text("更新")
            //                        .font(.largeTitle)
            //                        .fontWeight(.medium)
            //                    Button(action: addUpdate, label: {
            //                        Image(systemName: "plus.circle")
            //                    })
            //                    Spacer()
            //                    EditButton()
            //                }
            //                .padding()
            
            //拖动排序列表
            List {
                //置入Update数量
                ForEach(store.updates) { item in
                    //使点击后的UpdateDetail页面，展示点击按钮内的对应内容
                    NavigationLink(destination: UpdateDetail(title: item.title, text: item.text, image: item.image)) {
                        HStack(spacing: 12.0) {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height:80)
                                .background(Color("background"))
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.text)
                                    .lineLimit(2)
                                    //.lineSpacing(4)
                                    .font(.subheadline)
                                    .padding(.vertical, 1)
                                //.frame(height: 50)
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }
                //滑动删除
                .onDelete(perform: { indexSet in
                    self.store.updates.remove(at: indexSet.first!)
                })
                //排序
                .onMove(perform: move)
            }
            //导航标题
            .navigationBarTitle(Text("更新"))
            //添加、编辑按钮
            .navigationBarItems(
                leading: HStack(spacing: 12.0) {
                    Button(action: addUpdate, label: {
                        //                    Image(systemName: "plus.circle")
                        Text("Add")})},
                trailing: EditButton()
            )
            
            //            }
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
            .previewDevice("iPhone 8")
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image = ""
    var title = ""
    var text = ""
    var date = ""
}

let updateData = [
    Update(image: "Illustration1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "08/12"),
    Update(image: "Illustration2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "123"),
]

