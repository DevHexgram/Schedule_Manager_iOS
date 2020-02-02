//
//  AffairsView.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/3.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI

struct AffairsView: View {
    var body: some View {
        NavigationView {
            DailyAffairsView()
                .navigationBarTitle(Text("每日任务"))
            LongTermAffairsView()
                .navigationBarTitle(Text("长期事务"))
        }
    }
}

struct AffairsView_Previews: PreviewProvider {
    static var previews: some View {
        AffairsView()
    }
}
