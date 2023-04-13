//
//  SceneDelegate.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // Called when the app connects to a UIWindowScene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure we have a valid UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a UIWindow using the windowScene
        window = UIWindow(windowScene: windowScene)
        
        // Initialize the InitialViewModel
        let initialViewModel = InitialViewModel()
        // Pass the InitialViewModel to the InitialViewController
        let initialViewController = InitialViewController(viewModel: initialViewModel)
        // Create a UINavigationController with InitialViewController as the root view controller
        let navigationController = UINavigationController(rootViewController: initialViewController)
        
        // Set the UINavigationController as the root view controller for the UIWindow
        window?.rootViewController = navigationController
        // Make the UIWindow key and visible
        window?.makeKeyAndVisible()
    }
    
    // Called when a scene disconnects from the app
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    // Called when a scene becomes active (in the foreground)
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    // Called when a scene will resign active (move to the background)
    func sceneWillResignActive(_ scene: UIScene) { }
    
    // Called when a scene will enter the foreground
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    // Called when a scene enters the background
    func sceneDidEnterBackground(_ scene: UIScene) { (UIApplication.shared.delegate as? AppDelegate)?.saveContext() }
}
