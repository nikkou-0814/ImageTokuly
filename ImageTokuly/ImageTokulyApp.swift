import SwiftUI

@main
struct ImageTokulyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "Token") != nil {
                NavigationView {
                    ContentView()
                }
            } else {
                NavigationView {
                    LoginWebViewWrapper(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}
