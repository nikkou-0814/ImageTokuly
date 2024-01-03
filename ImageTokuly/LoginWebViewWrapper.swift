import SwiftUI

struct LoginWebViewWrapper: UIViewControllerRepresentable {
    var onReceiveToken: (String) -> Void

    init(onReceiveToken: @escaping (String) -> Void) {
        self.onReceiveToken = onReceiveToken
    }

    func makeUIViewController(context: Context) -> LoginWebView {
        let loginWebView = LoginWebView()
        loginWebView.onReceiveToken = onReceiveToken
        return loginWebView
    }

    func updateUIViewController(_ uiViewController: LoginWebView, context: Context) {
        // 更新が必要な場合の処理を追加
    }
}
