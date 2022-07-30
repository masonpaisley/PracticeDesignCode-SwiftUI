//
//  ContentView.swift
//  Shared
//
//  Created by jinzhao wang on 2022/7/31.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var showCard = false
    @State var viewState = CGSize.zero
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            //模糊
            BlurView(style: .systemMaterial)
                .edgesIgnoringSafeArea(.all)
            
            //标题和头图
            TitleView()
                .blur(radius: showCard ? 20 : 0)
                .animation(.easeIn)
            
            //第三张卡片
            CardView()
                .background(showCard ? Color("background9") : Color.gray)
                .cornerRadius(10)
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -320 : -40)
                .scaleEffect(0.85)
                .rotationEffect(Angle(degrees: showCard ? 0 : 8))
                .rotation3DEffect(
                    Angle(degrees: showCard ? 0 : 4),
                    axis: (x: 10.0 , y: 10.0, z: 10.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.7))
            
            //第二张卡片
            CardView()
                .background(showCard ? Color.red : Color("background8"))
                .cornerRadius(10)
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -260 : -24)
                .scaleEffect(0.9)
                .rotationEffect(Angle(degrees: showCard ? 0 : 4))
                .rotation3DEffect(
                    Angle(degrees: showCard ? 0 : 2),
                    axis: (x: 10.0 , y: 10.0, z: 10.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            //第一张卡片
            CertificateView()
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -200 : 0)
                .scaleEffect(0.95)
            //                .rotationEffect(Angle(degrees: showCard ? 0 : 0))
                .rotation3DEffect(
                    Angle(degrees: showCard ? 0 : 0),
                    axis: (x: 10.0 , y: 10.0, z: 10.0)
                )
                .animation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                    }
                    
                        .onEnded{ value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            //下方文案框
            CardButtonView(showCircle: $showCard)
                .offset(y: showCard ? UIScreen.main.bounds.height-600 : UIScreen.main.bounds.height)
                .offset(y: bottomState.height)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1 , duration : 0.8))
                // 手势拖动效果，控制bottomState的数值来调整offset的位置
                .gesture(
                    DragGesture().onChanged{ value in
                        self.bottomState = value.translation
                        if self.showFull {
                            self.bottomState.height += -300
                        }
                        
                        if self.bottomState.height < -300 {
                            self.bottomState.height = -300
                        }
                    }
                        .onEnded{ value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                                self.bottomState.height = -180
                                self.showFull = true
                            }else{
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //            .previewDevice("iPhone 8")
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            Text("Card Back")
                .frame(width: 340.0, height: 220.0)
        }
    }
}

struct CertificateView: View {
    var item = Certificate(title: "第一节 做梦", image: "Background", width: 340, height: 220)
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("accent"))
                        .padding(.top)
                    Text("韭菜盒子里那美味的韭菜")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
            }
            .padding(.horizontal)
            Spacer()
            Image(item.image)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .offset(y: 20)
        }
        .frame(width: CGFloat(item.width), height: CGFloat(item.height))
        .background(Color.black)
        .cornerRadius(10.0)
        .shadow(radius: 10.0)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("文章")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Spacer()
            }
            Image("Illustration5")
            Spacer()
        }.padding()
    }
}

struct CardButtonView: View {
    @Binding var showCircle: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Rectangle()
                .frame(width: 60.0, height: 6.0)
                .cornerRadius(3.0)
                .opacity(0.1)
            Text("你生命中的点滴会串联起来，这构成了你的未来，总有一天你会死去，这一切都无关紧要，好好爱你身边的人，做一些积极的事情，散播你的智慧，影响他人。")
                .foregroundColor(.black)
                .lineLimit(3)
            HStack(spacing: 20) {
                //进度圈
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), width: 88, height: 88, percent: 82, showCircle: $showCircle)
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("进度")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("圆形进度条有动画效果，进度可以跟着数字一起变化balabala")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .lineSpacing(4)
                        .lineLimit(2)
                }
                .padding()
                //                .frame(width: 200, height: 100)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 8)
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.horizontal)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(25)
        .shadow(radius: 20)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
