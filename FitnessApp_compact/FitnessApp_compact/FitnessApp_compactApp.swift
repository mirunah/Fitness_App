//
//  FitnessApp_compactApp.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 20.05.2023.
//

import SwiftUI
import Firebase

@main
struct FitnessApp_compactApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("setting up firebase")
        FirebaseApp.configure()
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    
    private let userService: UserServiceProtocol
    
    init (UserService: UserServiceProtocol = UserService()) {
        self.userService = UserService
        try? Auth.auth().signOut()
        userService
            .observeAuthChanges()
            .map { $0 != nil } //this will give us a true of false
            .assign(to: &$isLoggedIn)
        
    }
}
