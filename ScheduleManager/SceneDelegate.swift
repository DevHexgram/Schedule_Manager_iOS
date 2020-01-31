////
////  SceneDelegate.swift
////  ScheduleManager
////
////  Created by ljz on 2020/1/26.
////  Copyright © 2020 DevHexgram. All rights reserved.
////
//
//import UIKit
//import SwiftUI
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    let sharedUD = UserDefaults.init(suiteName: "sch.man")
////    var token = sharedUD?.string(forKey: "token")
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//
//        // Create the SwiftUI view that provides the window contents.
////        let contentView = ContentView()
//        let registView = RegistView(
////            triggerLoginView: {
//////                self.dismiss(animated: true)
////                print("!")
//////                self.window?.removeFromSuperview()
////                if let windowScene = scene as? UIWindowScene {
////                    let window = UIWindow(windowScene: windowScene)
////                    window.rootViewController = UIHostingController(rootView: loginView)
////                    self.window = window
////                    window.makeKeyAndVisible()
////                }
////            }
//        )
//        let loginView = LoginView(
////            triggerWebViewFunc: {
////            (self.presentingViewController?.children[0] as! ViewController).shortcutFired(nativeLogin: true)
////            },
////            triggerNewFuncGuideFunc: {
////            let sharedUd = UserDefaults.init(suiteName: "group.help.hdu.lemon.ios")
////            let lastShowedVersion = Int(sharedUd?.string(forKey: "lastVersionGuided") ?? "0")
////            let currentVersion = Int(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
////            if currentVersion ?? 0 > lastShowedVersion ?? 0 {
////                (self.presentingViewController?.children[0] as! ViewController).performSegue(withIdentifier: "gotoNewFuncGuide", sender: self)
////                }
////            },
//            triggerRegistView: {
//                self.window?.rootViewController = UIHostingController(rootView: registView)
//            })
//        // Use a UIHostingController as window root view controller.
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: loginView)
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }
//
//
//}
//



//https://fleetingpixels.com/blog/2019/6/7/customising-nstoolbar-in-uikit-for-mac-marzipancatalyst

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the
        // UIWindow `window` to the provided UIWindowScene `scene`.
      
        // If using a storyboard, the `window` property will
        // automatically be initialized and attached to the scene.
      
        // This delegate doesn't imply the connecting scene or session are new
        // (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        #if targetEnvironment(macCatalyst)
            if let windowScene = scene as? UIWindowScene {
                if let titlebar = windowScene.titlebar {
                    titlebar.titleVisibility = .hidden
                    titlebar.autoHidesToolbarInFullScreen = true
                }
            }
        #endif
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
