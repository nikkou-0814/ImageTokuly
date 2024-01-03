import SwiftUI
import WebKit
import UIKit

struct LoginWebViewWrapper: UIViewControllerRepresentable {
    @Binding var isLoggedIn: Bool

    func makeUIViewController(context: Context) -> LoginWebView {
        let loginWebView = LoginWebView(isLoggedIn: $isLoggedIn)
        return loginWebView
    }

    func updateUIViewController(_ uiViewController: LoginWebView, context: Context) {
        // Add necessary update logic here
    }
}

class LoginWebView: UIViewController, WKNavigationDelegate {
    var webView = WKWebView()
    @Binding var isLoggedIn: Bool

    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self

        let userAgent = "TokulyAppWebview"
        webView.customUserAgent = userAgent

        if let url = URL(string: "https://tokuly.com/app/login") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        view = webView
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
        url.absoluteString.hasPrefix("https://tokuly.com/app/login/success"),
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
        let token = components.queryItems?.first(where: { $0.name == "token" })?.value {
            print("Token: \(token)")

            UserDefaults.standard.set(token, forKey: "Token")

            decisionHandler(.cancel)
            
            // Navigate to ContentView
            let contentView = ContentView()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = UIHostingController(rootView: contentView)
                    window.makeKeyAndVisible()
                }, completion: nil)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}
