//
//  Homelist.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/8/30.
//
import SwiftUI
import UIKit

struct Homelist: View {
    @State var showCard = false
    var Courses = courseData
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                //标题
                HStack {
                    VStack(alignment: .leading) {
                        Text("书单")
                            //                            .font(.largeTitle)
                            .modifier(NotoFont(size: 28))
                        //                            .fontWeight(.heavy)
                        Text("22个")
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 64.0)
                    .padding(.top, 12.0)
                    Spacer()
                }
                
                //ScrollView使其可以滚动，horizontal表示可以水平滚动，showsIndicators是滚动条
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingView()
                        .padding(.horizontal, 30.0)
                        .padding(.bottom, 24.0)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                //横向可滚动的卡片布局
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        //展示coursedata中的数量
                        ForEach(Courses) { item in
                            Button(action: { self.showCard.toggle() }, label: {
                                //调用coursedata中的数据
                                GeometryReader { geometry in
                                    HomeCard(title: item.title,
                                             image: item.image,
                                             color: item.color,
                                             shadowColor: item.shadowColor)
                                        //.padding(.vertical, 30.0)
                                        //.padding()
                                        //被点击时调用contentview
                                        .sheet(isPresented: self.$showCard, content: {
                                            ContentView()
                                                .ignoresSafeArea()
                                        })
                                        //滑动时滚动动画
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 28) / -40 ), axis: (x: 0.0, y: 10.0, z: 0))
                                }
                                .frame(width: 240, height: 224)
                            }
                            )}
                    }
                    .padding(.leading, 28)
                    .padding(.top, 10.0)
                    .padding(.bottom, 60)
                    Spacer()
                }
                .offset(y: -20)
                
                CertificateRow()
                    .offset(y: -40)
                
                BookList()
            }
            .padding(.top , 44)
        }
    }
}

struct Homelist_Previews: PreviewProvider {
    static var previews: some View {
        Homelist(showContent: .constant(false))
            .previewDevice("iPhone 12")
    }
}

struct HomeCard: View {
    var title = ""
    var title2 = ""
    var image = ""
    var color = Color("")
    var shadowColor = Color("")
    var width:CGFloat = 240
    var height:CGFloat = 244
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(spacing: 4.0) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding([.top, .leading, .trailing], 24)
                        .lineLimit(2)
                        .frame(width: width - 40, alignment: .topLeading)
                    Text(title2)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .lineLimit(2)
                        .frame(width: width - 40, alignment: .topLeading)
                }
                Spacer()
            }
            Spacer()
            Image(image)
                .resizable()
                //                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 240, height: 120)
                .padding(.bottom)
        }
        //        .padding()
        .frame(width: width, height: height)
        .background(color)
        .cornerRadius(20)
        .shadow(color: shadowColor, radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

let courseData = [
    Course(title: "如何在一天内读10000本书",
           image: "Illustration1",
           color: Color("background3"),
           shadowColor: Color("backgroundShadow3")
    ),
    Course(title: "如何做梦",
           image: "Illustration2",
           color: Color("background4"),
           shadowColor: Color("backgroundShadow4")
    ),
    Course(title: "如何量子阅读",
           image: "Illustration2",
           color: Color("background5"),
           shadowColor: Color("backgroundShadow4")
    ),
    Course(title: "如何倒立读书",
           image: "Illustration2",
           color: Color("background6"),
           shadowColor: Color("backgroundShadow4")
    ),
    Course(title: "如何倒立读书",
           image: "Illustration2",
           color: Color("background7"),
           shadowColor: Color("backgroundShadow4")
    ),
]

struct WatchRingView: View {
    var body: some View {
        HStack(spacing: 20.0) {
            HStack(spacing: 8) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 82, showCircle: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("《蚱蜢》")
                        .bold()
                        .modifier(Font())
                    Text("游戏、生命与乌托邦")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(8)
            .padding(.leading, 4.0)
            .frame(width: 180, height: 64)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(Shadow())
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), color2: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), width: 32, height: 32, percent: 52, showCircle: .constant(true))
            }
            .padding(8)
            //                .frame(width: 200, height: 100)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(Shadow())
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), color2: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), width: 32, height: 32, percent: 20, showCircle: .constant(true))
            }
            .padding(8)
            //                .frame(width: 200, height: 100)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(Shadow())
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color2: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), width: 32, height: 32, percent: 70, showCircle: .constant(true))
            }
            .padding(8)
            //                .frame(width: 200, height: 100)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(Shadow())
        }
    }
}
