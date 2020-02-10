//
//  DailyAffairsView.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/3.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI
import SwiftUIPullToRefresh
import Alamofire

struct DailyAffairsView: View {
    @State var dailyAffair: [DAffair] = []
    
    var body: some View {
        RefreshableNavigationView(title: "每日任务", action: {
            self.dailyAffair.removeAll()
            self.refresh()
        }){
            ForEach(self.dailyAffair, id: \.self){ df in
                VStack(alignment: .leading){
                    Text("\(df.title)")
                    Divider()
                }
            }
        }
    }
    func refresh() -> Int {
        let sharedUd = UserDefaults.init(suiteName: "sch.man")
        let token = sharedUd?.string(forKey: "token")
        let header = ["Authorization": token]
//        var isSuccess: Bool = true
        Alamofire.request("http://www.sweetbeecr.com:1221/all/dailyAffairs", method: .get, headers: header as! HTTPHeaders).responseJSON {
            response in
            switch response.result {
            case .success:
//                print("sccess")
                let json = response.result.value
                let data = (json as! NSDictionary).object(forKey: "data") as! NSArray
                for da in data {
                    var tempAffair: DAffair! = DAffair(id: 0, title: "", extra: "")
                    let temp = da as! NSDictionary
                    tempAffair.title = temp.object(forKey: "Title") as! String
                    tempAffair.id = temp.object(forKey: "ID") as! Int
                    tempAffair.extra = temp.object(forKey: "Extra") as! String
                    self.dailyAffair.append(tempAffair)
                    print(self.dailyAffair)
//                    self.rootView = MainView(dailyAffair: self.DailyAffair)
                }
            case .failure:
//                print("failure \(response.request)")
//                isSuccess = false
                Alert(title: Text("提示"), message: Text("链接服务器失败，请检查网络"), dismissButton: .default(Text("好")))
            }
        }
        return 1
    }
}

//struct DailyAffairsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyAffairsView()
//    }
//}
