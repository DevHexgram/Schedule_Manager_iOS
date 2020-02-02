//
//  LoginController.swift
//  ScheduleManager
//
//  Created by ljz on 2020/1/31.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class LoginController: UIHostingController<LoginView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: LoginView())
    //    let vc = self.presentingViewController?.children[0] as! ViewController
        self.rootView = LoginView(
//            triggerWebViewFunc: {
//                (self.presentingViewController?.children[0] as! ViewController).shortcutFired(nativeLogin: true)
//            },
//            triggerNewFuncGuideFunc: {
//                let sharedUd = UserDefaults.init(suiteName: "group.help.hdu.lemon.ios")
//                let lastShowedVersion = Int(sharedUd?.string(forKey: "lastVersionGuided") ?? "0")
//                let currentVersion = Int(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
//                if currentVersion ?? 0 > lastShowedVersion ?? 0 {
//                    (self.presentingViewController?.children[0] as! ViewController).performSegue(withIdentifier: "gotoNewFuncGuide", sender: self)
//                }
//            },
            triggerMainView: {
                self.performSegue(withIdentifier: "gotoMain", sender: self)
        }, dismissFunc: {
            self.dismiss(animated: true, completion: nil)
        }, triggerRegistView: {
            self.performSegue(withIdentifier: "gotoRegist", sender: self)
        }
        )
    }
}
