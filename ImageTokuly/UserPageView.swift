import SwiftUI
import UIKit

struct UserPageView: View {
    enum AlertType: Identifiable {
        case logoutConfirmation
        case logoutCompletion

        var id: Int {
            switch self {
            case .logoutConfirmation:
                return 1
            case .logoutCompletion:
                return 2
            }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    @State private var userInfo: UserInfo?
    @State private var isLoading = false
    @State private var navigateToLogin = false
    @State private var alertType: AlertType? = nil
    
    let url = URL(string: "https://tokuly.com/dashboard")!
    
    var body: some View {
        VStack {
            if let userInfo = userInfo {
                HStack {
                    if let imageUrl = URL(string: userInfo.profile_photo_url) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFill() // Change this line
                                .frame(width: 70, height: 70)
                                .clipShape(Circle()) // Move this line up
                                .padding(10)
                        } placeholder: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill() // Change this line
                                .frame(width: 70, height: 70)
                                .clipShape(Circle()) // Move this line up
                                .padding(10)
                        }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .cornerRadius(15)
                            .padding(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(userInfo.name)
                            .font(.system(size: 30).bold())
                            .foregroundColor(.primary)
                        Text("@" + userInfo.handle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color(colorScheme == .dark ? .white.opacity(0.1) : .white))
                .cornerRadius(20)
                .shadow(color: Color(colorScheme == .dark ? .white : .black).opacity(0.3), radius: 10, x: 0, y: 5)
                Button(action: {
                    vibration()
                    UIApplication.shared.open(url)
                }) {
                    Text("ダッシュボードを開く")
                        .frame(maxWidth: .infinity)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .padding(.vertical, 15) // 上下
                        .background(Color(colorScheme == .dark ? .white.opacity(0.1) : .white))
                        .cornerRadius(15)
                        .foregroundColor(.primary)
                        .shadow(color: Color(colorScheme == .dark ? .white : .black).opacity(0.3), radius: 10, x: 0, y: 5)
                        .font(.system(size: 20).bold())
                        .padding()
                }
                Button(action: {
                    vibration()
                    self.alertType = .logoutConfirmation
                }) {
                    Text("ログアウト")
                        .frame(maxWidth: .infinity)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .padding(.vertical, 15) // 上下
                        .background(Color(.red))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .shadow(color: Color(.red), radius: 10, x: 0, y: 0)
                        .font(.system(size: 20).bold())
                }
                .alert(item: $alertType) { alertType in
                    switch alertType {
                    case .logoutConfirmation:
                        return Alert(title: Text("ログアウト"), message: Text("ログアウトしてもよろしいですか？"), primaryButton: .destructive(Text("ログアウト")) {
                            UserLogout()
                            UserDefaults.standard.removeObject(forKey: "Token") // トークンを削除
                            print("Token was removed.") // Add this line
                            self.alertType = .logoutCompletion // Add this line
                        }, secondaryButton: .cancel(Text("キャンセル"))) // Change this line
                    case .logoutCompletion:
                        return Alert(title: Text("ログアウト完了"), message: Text("ログアウトが完了しました。アプリを終了します。"), primaryButton: .destructive(Text("OK")) {
                            exit(0)
                        }, secondaryButton: .cancel(Text("キャンセル"))) // Change this line
                    }
                }
            } else if isLoading {
                Text("Loading...")
            } else {
                Text("No user information available.")
            }
        }
        .onAppear {
            loadUserInfo()
        }
    }
    
    func loadUserInfo() {
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            print("Token not found")
            return
        }
        print(token)
        isLoading = true
        let url = URL(string: "https://api.tokuly.com/auth/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyParameters = "token=\(token)"
        request.httpBody = bodyParameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response: (httpResponse)")
                }
                
                guard let data = data else {
                    print("No data")
                    return
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: " + jsonString)
                } else {
                    print("Invalid JSON data")
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(UserInfo.self, from: data)
                    self.userInfo = decodedResponse
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
    func UserLogout() {
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            print("Token not found")
            return
        }
        print(token)
        isLoading = true
        let url = URL(string: "https://api.tokuly.com/auth/logout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyParameters = "token=\(token)"
        request.httpBody = bodyParameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request).resume()
    }

}
