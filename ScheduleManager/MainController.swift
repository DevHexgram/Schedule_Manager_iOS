//
//  MainViewController.swift
//  ScheduleManager
//
//  Created by ljz on 2020/2/3.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Alamofire

class MainController: UIHostingController<MainView> {

    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        super.init(coder: aDecoder, rootView: MainView())
    //    let vc = self.presentingViewController?.children[0] as! ViewController
    }
}
