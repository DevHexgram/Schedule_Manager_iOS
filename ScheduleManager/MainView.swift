//
//  MainView.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/3.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI
import Alamofire

struct MainView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection){
//            Text(dailyAffair[0].title)
            HStack {
                AffairsView()
                Text("main")
            }
             .tabItem {
                 VStack {
                     Image("first")
                     Text("事务")
                 }
             }
             .tag(0)
            Text("Second View")
             .tabItem {
                VStack {
                    Image("second")
                    Text("更多")
                }
            }
            .tag(1)
            Text("Settings")
             .tabItem {
                VStack {
                    Image("second")
                    Text("设置")
                }
            }
            .tag(2)
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
