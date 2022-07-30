//
//  Home.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/8/28.
//
import SwiftUI
import UIKit

let screen = UIScreen.main.bounds

struct Home: View {
    @State var showMenu = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            HomeView(showMenu: $showMenu)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30 , style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showMenu ? -420 : 0)
                .rotation3DEffect(Angle(degrees: showMenu ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showMenu ? 0.9 : 1)
                .animation(.spring(response: 0, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            // 显示下方注销视图，因为放在 HomeButton 的.sheet内会有白色背景，所以只能先放这了
            MenuViewDown()
                .background(Color.black.opacity(0.01))
                .offset(y : showMenu ? 0 : UIScreen.main.bounds.height)
                .offset(y : viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showMenu.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        if self.viewState.height > 50 {
                            self.showMenu = false
                        }
                        self.viewState = .zero
                    }
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home().previewDevice("iPhone SE")
                .environmentObject(EnvironmentStore())
            //            Home().previewDevice("iPhone Xr")
            //            Home().previewDevice("iPad Pro (9.7-inch)")
        }
    }
}

struct MenuRow: View {
    var image = ""
    var text = ""
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color("icons"))
                .imageScale(.large)
                //                .font(Font.system(size: 20, weight: .bold))
                .frame(width: 36.0, height: 36.0)
            Text(text)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu: Identifiable {
    var id = UUID()
    var title = ""
    var icon = ""
}

let menuData = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Setting", icon: "gear"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.2"),
    Menu(title: "Sign Out", icon: "arrow.uturn.down")
]

struct MenuVIew: View {
    var Menu = menuData
    @Binding var show : Bool
    @State var showSetting : Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Menu) { num in
                    if num.title == "Setting" {
                        Button(action: { self.showSetting.toggle() }, label: {
                            MenuRow(image: num.icon, text: num.title)
                        }).sheet(isPresented: $showSetting, content: {
                            Setting()
                        })
                    } else {
                        MenuRow(image: num.icon, text: num.title)
                    }
                }
                Spacer()
            }
            .padding(.top, 20.0)
            .padding(20.0)
            .frame(minWidth: 0, maxWidth: 360, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .background(Color("button"))
            .cornerRadius(20)
            .padding(.trailing, 80)
            .shadow(radius: 10)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0.0, y: 10.0, z: 0.0))
            .animation(.easeIn)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, 40)
    }
}

struct CircleButton: View {
    var icon = "arrow.uturn.down"
    
    var body: some View {
        HStack {
            Image(systemName: icon )
                .foregroundColor(Color("icons"))
                .imageScale(.large)
            //                .font(Font.system(size: 20, weight: .bold))
        }
        .frame(width: 44, height: 44)
        .background(Color("button"))
        .clipShape(Circle())
        .shadow(color: Color("buttonShadow"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
    }
}

struct MenuButton: View {
    @Binding var show : Bool
    
    var body: some View {
        ZStack {
            Button(action: { self.show.toggle() }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .foregroundColor(Color("icons"))
                        .imageScale(.large)
                    //                        .font(Font.system(size: 20, weight: .bold))
                }
                .padding(.trailing, 20)
                .frame(width: 90.0, height: 60.0)
                .background(Color("button"))
                .cornerRadius(/*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                .shadow(color: Color("buttonShadow"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
            })
            .offset(x: -30, y: 0)
        }
    }
}

struct HomeButton: View {
    @Binding var showMenu : Bool
    @State var viewState = CGSize.zero
    
    var body: some View {
        HStack {
            Button(action: { self.showMenu.toggle() }, label: {
                CircleButton(icon: "person.circle")
            })
        }
    }
}


struct RingButton: View {
    @Binding var show : Bool
    var body: some View {
        HStack {
            Button(action: { self.show.toggle() }, label: {
                CircleButton(icon: "bell.circle")
            }).sheet(isPresented: $show) {
                UpdateList()
            }
        }
    }
}


struct HomeView: View {
    @State var show = false
    @State var showProfile = false
    @State var showUpdate = false
    @State var showContent = false
    @EnvironmentObject var hideButton: EnvironmentStore

    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            //主页展示名片和横向卡片，点击时，增加模糊效果
            Homelist(showContent: $showContent)
                .background(
                    //背景径向渐变
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                            .edgesIgnoringSafeArea(.all)
                        Spacer()
                    }
                        .background(Color.white)
                )
                .blur(radius: show ? 20 :0)
                .scaleEffect(showProfile ? 0.95 : 1)
                .animation(.default)
            
            VStack {
                HStack {
                    //侧边栏按钮
                    MenuButton(show: $show)
                    Spacer()
                    //资料和消息通知按钮
                    HomeButton(showMenu: $showMenu)
                    RingButton(show: $showUpdate)
                }
                .modifier(Shadow())
                .animation(.default)
                .offset(y: showProfile ? 60 : 0)
                .offset(y: hideButton.hide ? -120 : 0)
                Spacer()
            }
            .padding(.top , 44)
            
            //侧边栏显示
            MenuVIew(show: $show, showSetting: false)
            
            //点ringview时，显示contentview视图
            if showContent {
//                Color.white
                ContentView()
                    .padding(.top , 44)
                    .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale))
                
                //右上角退出按钮
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .onTapGesture {
                                self.showContent = false
                            }
                    }
                    Spacer()
                }
                .padding(.top , 44)
                .offset(x: -20, y: 20)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.5))
            }
        }
    }
}
