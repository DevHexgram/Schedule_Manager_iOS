//
//  Affair.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/3.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import SwiftUI

struct LTAffair: Identifiable {
    var uuid = UUID()
    var id: Int
    var title: String
    var deadline: String
    var extra: String
    var created_at: String
}

struct DAffair: Hashable, Codable, Identifiable {
//    var uuid = UUID()
    var id: Int
    var title: String
    var extra: String
}
