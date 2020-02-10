//
//  LoginView.swift
//  ScheduleManager
//
//  Created by ljz on 2020/1/26.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI
import Alamofire
import UIKit

struct LoginView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
//    @ObjectBinding private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var username: String = ""
    @State var password: String = ""
    @State var Login: String = "登录"
    @State var tip: String = ""
    @State var isDisabled: Bool = false
    @State var showErr: Int = 0
    @State private var showingAlert: Bool = false
    var triggerMainView: (() -> Void)?
    var dismissFunc: (() -> Void)?
    var triggerRegistView: (() -> Void)?
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //限制只能输入数字，不能输入特殊字符
        let length = string.lengthOfBytes(using: String.Encoding.utf8)
        for loopIndex in 0..<length {
            let char = (string as NSString).character(at: loopIndex)
            if char < 48 { return false }
            if char > 57 { return false }
        }
        //限制长度
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > 11 { return false }
        return true
    }
    var body: some View {
//        NavigationView {
        VStack{
            Image("login")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .clipShape(Circle())
                .offset(y: -150)
            VStack {
//                Text("快和我签订契约嘤~")
//                    .padding(.bottom)
//                    .offset(y: -150)
//                    .font(.footnote)
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
                    self.Login = "登录中..."
//                    self.password = self.password.trimmingCharacters(in: [" ","\t"])
//                    let data = self.password.data(using: String.Encoding.utf8)
//                    let base64Pass = data!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                    let parameters: Parameters = ["username": self.username, "password": self.password]
                    Alamofire.request("http://www.sweetbeecr.com:1221/auth/login",method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                        print("!!!\(response)")
                        switch response.result {
                            case .success:
                                let json = response.result.value
//                                print(json)
                                let msg = (json as! NSDictionary).object(forKey: "msg") as! String
                                 let err = (json as! NSDictionary).object(forKey: "error") as! Int
                                if msg == "success" {
                                    let newRawData = (json as! NSDictionary).object(forKey: "data") as! NSDictionary
                                    //let isValid = newRawData.object(forKey: "isValid") as! Bool
                                    let sharedUd = UserDefaults.init(suiteName: "sch.man")
                                    let token = newRawData.object(forKey: "token") as! String
                                    sharedUd?.set(token, forKey: "token")
                                    sharedUd?.synchronize()
//                                    self.triggerWebViewFunc?()
//                                    self.dismissFunc?()
                                    self.triggerMainView?()
                                    self.tip = ""
//                                    self.triggerNewFuncGuideFunc?()
                                }
                                else {
                                    if err != 0 {
                                        self.showErr = err
                                        self.showingAlert = true
                                    }
                                    self.Login = "登录"
                                    self.tip = "登录失败，请检查账号或密码"
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                    //                // Put your code which should be executed with a delay here
                                            self.tip = ""
                                        })
                                    self.isDisabled = false
                                }
//                                print("\(msg) \n")
//                                print(parameters)
                            case .failure:
                                self.Login = "登录"
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
                        Text("\(Login)")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 105)
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .font(.headline)
                    }
                    }.disabled(isDisabled)
                    .background(Color.init(UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)))
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    .cornerRadius(30)
            }
            HStack {
                Text("还没账号？")
                    .font(.footnote)
                Button(action: {
                    self.triggerRegistView?()
                }){
                        Text("戳我注册")
                            .font(.footnote)
                }
            }.offset(y: 150)
        }
            .padding(.horizontal, 40)
            .offset(y: kGuardian.slide)
            .animation(.easeInOut)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
