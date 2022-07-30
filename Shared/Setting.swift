//
//  Setting.swift
//  Setting
//
//  Created by jinzhao wang on 2021/9/5.
//

import SwiftUI

struct Setting: View {
    @State var turnOn = false
    @State var num = 1
    @State var selection = 1
    @State var date = Date()
    @State var email = ""
    @State var submit = false
    
    var body: some View {
        NavigationView {
            Form {
                //开关
                Toggle(isOn: $turnOn) {
                    Text("接收通知")
                }
                
                //计数
                Stepper(value: $num, in: 1...10) {
                    Text("\(num) Notification\(num > 1 ? "s" : "") per week")
                }
                
                //选择器
                Picker(selection: $selection, label: Text("最喜欢的语言"), content: {
                    Text("SwiftUI").tag(1)
                    Text("React").tag(2)
                })
                
                //日期选择器
                DatePicker(selection: $date) {
                    Text("日期")
                }
                
                //输入框
                Section(header: Text("邮箱")) {
                    HStack {
                        TextField("输入你的邮箱", text: $email)
                            //增加文本框边框
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: { self.submit.toggle() }, label: { Text("Submit") })
                            .alert(isPresented: $submit) {
                                Alert(title: Text("Thanks"), message: Text("Email: \(email)"))
                            }
                            .padding(.horizontal,8)
                    }
                }
            }
            .navigationBarTitle("设置")
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
