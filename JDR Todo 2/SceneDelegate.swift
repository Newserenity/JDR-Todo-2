//
//  SceneDelegate.swift
//  JDR Todo 2
//
//  Created by Jayden Jang on 2023/06/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /**
     * - Description: 네비게이션컨트롤러를 생성하여 각각의 VC를 보여준다
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarC = UITabBarController()

        let mainVC = UINavigationController(rootViewController: MainVC())
        let settingVC = UINavigationController(rootViewController: SettingVC())
        
        mainVC.title = "Main"
        settingVC.title = "Setting"
        
        tabBarC.setViewControllers([
            mainVC,
            settingVC
        ], animated: true)
        
        tabBarC.modalPresentationStyle = .fullScreen
        tabBarC.tabBar.backgroundColor = .white
        tabBarC.tabBar.tintColor = .systemOrange
        tabBarC.tabBar.layer.borderWidth = 0.3
        tabBarC.tabBar.layer.borderColor = UIColor.lightGray.cgColor

        guard let items = tabBarC.tabBar.items else { return }
        items[0].image = UIImage(systemName: "list.bullet")
        items[1].image = UIImage(systemName: "command")
        
        // 기본루트뷰를 탭바컨트롤러로 설정
        window?.rootViewController = tabBarC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

