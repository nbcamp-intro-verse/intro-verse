//
//  SceneDelegate.swift
//  Intro-verse
//
//  Created by Seungho Jang on 3/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let rootViewController = ViewController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}
