//
//  errorHandler.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/1.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI
import UIKit

struct ErrorHandler: View {
    @State var tip: String?
    @Binding var showingAlert: Bool
    @State var code: Int?
    init(err: Int, tip: String, show: Binding<Bool>) {
        print("init")
        self._showingAlert = show
        switch err {
            case 40000: _tip = State(initialValue: "您填写的格式有误")
            case 40420: _tip = State(initialValue: "您的邀请码错误")
            case 40430: _tip = State(initialValue: "您操作的事务不存在")
            case 30200: _tip = State(initialValue: "您的登录已过期，请重新登陆")
            case 40410: _tip = State(initialValue: "您的账号或密码错误")
            default:
                _tip = State(initialValue: "未知错误，请与我们联系")
        }
    }
    var body: some View {
        VStack {
            Button(action: {
                self.showingAlert = true
            }) {
                Text("")
            }
            .alert(isPresented: $showingAlert)
            {
                Alert(title: Text("提示"), message: Text("\(self.tip ?? "")"), dismissButton: .default(Text("Got it!")))
            }
//            Text(" ").alert(isPresented: $showingAlert) {
//                Alert(title: Text("提示"), message: Text("\(self.tip ?? "")"), dismissButton: .default(Text("Got it!")))
//            }
        }
    }
}

//struct ErrorHandler_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorHandler(err: 40000, tip: "")
//    }
//}
