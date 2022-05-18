//
//  SceneDelegate.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let initialScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: initialScene.coordinateSpace.bounds)
        window?.windowScene = initialScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarVC = UITabBarController()
        
        tabBarVC.tabBar.tintColor = .label
        tabBarVC.setViewControllers([createNewsTabBar(), createLaunchesTabBar(), createReportsTabBar()], animated: true)
        
        return tabBarVC
    }
    
    func createNewsTabBar() -> UINavigationController {
        let newsNC = UINavigationController(rootViewController: NewsViewController())
        newsNC.tabBarItem = UITabBarItem(title: NewsViewController.newsVCTitle, image: UIImage.SFYTabbar.news, tag: 0)
        return newsNC
    }
    
    func createLaunchesTabBar() -> UINavigationController {
        let launchesViewModel = LaunchesViewModel()
        let launchesVC = LaunchesViewController(viewModel: launchesViewModel)
        let launchesNavController = UINavigationController(rootViewController: launchesVC)
        
        launchesNavController.navigationBar.tintColor = .label
        launchesNavController.tabBarItem = UITabBarItem(title: launchesViewModel.title, image: UIImage.SFYTabbar.launches, tag: 1)
        
        return launchesNavController
    }
    
    func createReportsTabBar() -> UINavigationController {
        let reportsVC = UINavigationController(rootViewController: ReportsViewController())
        reportsVC.tabBarItem = UITabBarItem(title: ReportsViewController.reportsVCTitle, image: UIImage.SFYTabbar.reports, tag: 2)
        return reportsVC
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

