//
//  RegistView.swift
//  ScheduleManager
//
//  Created by ljz on 2020/1/31.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI
import Alamofire
import UIKit

struct RegistView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    //    @ObjectBinding private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var username: String = ""
    @State var password: String = ""
    @State var regist: String = "戳我注册"
    @State var tip: String = ""
    @State var isDisabled: Bool = false
    @State var inviteCode: String = ""
    @State var showErr: Int = 0
    @State private var showingAlert: Bool = false
    //    var triggerMianViewFunc: (() -> Void)?
    //    var triggerNewFuncGuideFunc: (() -> Void)?
    var triggerLoginView: (() -> Void)?
//    var triggerLoginView: (() -> Void)?
    var body: some View {
        VStack{
            Image("login")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .clipShape(Circle())
                .offset(y: -150)
            VStack {
                Text("快和我签订契约嘤~")
                    .padding(.bottom)
                    .offset(y: -150)
                    .font(.footnote)
                VStack {
                    
                    TextField("账号", text: $username, onEditingChanged: { target in
                        if target { self.kGuardian.showField = 0 }
                    })
                        .cornerRadius(3)
                        .lineSpacing(15)
                        .padding()
                        .frame(width: 250, alignment: .center)
                        .background(Color.init(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.3)))
                        .cornerRadius(30)
                        .multilineTextAlignment(TextAlignment.center)
                    TextField("邀请码", text: $inviteCode, onEditingChanged: { target in
                        if target { self.kGuardian.showField = 0 }
                    })
                        .cornerRadius(3)
                        .lineSpacing(15)
                        .padding()
                        .frame(width: 250, alignment: .center)
                        .background(Color.init(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.3)))
                        .cornerRadius(30)
                        .multilineTextAlignment(TextAlignment.center)
                    SecureField("密码", text: $password, onCommit: {
                        self.kGuardian.showField = 0
                    })
                        .cornerRadius(3)
                        .lineSpacing(15)
                        .padding()
                        .frame(width: 250, alignment: .center)
                        .background(Color.init(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.3)))
                        .cornerRadius(30)
                        .multilineTextAlignment(TextAlignment.center)
                }
                Text(tip)
                    .font(.footnote)
               //     .padding(.top, 5)
                    .padding(.bottom, 2.5)
                Button(action: {
                    self.isDisabled = true
                    self.regist = "注册中..."
//                    self.password = self.password.trimmingCharacters(in: [" ","\t"])
//                    let data = self.password.data(using: String.Encoding.utf8)
//                    let base64Pass = data!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                    let parameters: Parameters = ["username": self.username, "password": self.password, "code": self.inviteCode]
                    Alamofire.request("http://www.sweetbeecr.com:1221/auth/register",method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                        switch response.result {
                            case .success:
                                let json = response.result.value
                                let msg = (json as! NSDictionary).object(forKey: "msg") as! String
                                let err = (json as! NSDictionary).object(forKey: "error") as! Int
                                if msg == "success" {
                                    print("success")
                                    let newRawData = (json as! NSDictionary).object(forKey: "data") as! NSDictionary
                                    let sharedUd = UserDefaults.init(suiteName: "sch.man")
                                    let token = newRawData.object(forKey: "token") as! String
                                    sharedUd?.set(token, forKey: "token")
                                    sharedUd?.synchronize()
                                    print(token)
                                    self.triggerLoginView!()
                                }
                                else {
                                    if err != 0 {
                                        self.showErr = err
                                        self.showingAlert = true
                                    }
                                    self.regist = "戳我注册"
                                    self.isDisabled = false
                                }
                            case .failure:
                                self.regist = "注册"
                                self.tip = "登录失败，请检查网络"
                                self.isDisabled = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                // Put your code which should be executed with a delay here
                                    self.tip = ""
                                })
                        }
                    })
                }){
                    VStack {
                        Text("\(regist)")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 90)
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .font(.headline)
                            //.padding(.leading, 10)
                    }
                    }.disabled(isDisabled)
                    .background(Color.init(UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)))
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    .cornerRadius(30)
            }
            HStack {
                Text("已有账号？下拉回去登录")
                    .font(.footnote)
            }.offset(y: 150)
            if self.showErr != 0 {
                ErrorHandler(err: self.showErr, tip: "", show: self.$showingAlert)
            }
        }
            .padding(.horizontal, 40)
            .offset(y: kGuardian.slide)
            .animation(.easeInOut)
    }
}

struct RegistView_Previews: PreviewProvider {
    static var previews: some View {
        RegistView()
    }
}
