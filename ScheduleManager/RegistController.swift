//
//  RegistController.swift
//  ScheduleManager
//
//  Created by ljz on 2020/1/31.
//  Copyright © 2020 DevHexgram. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class RegistController: UIHostingController<RegistView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: RegistView())
    //    let vc = self.presentingViewController?.children[0] as! ViewController
        self.rootView = RegistView(
            triggerLoginView: {
                self.dismiss(animated: true, completion: nil)
            }
        )
        
    }
}
