import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    @Binding var isModalDisplayed: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.modalPresentationStyle = .fullScreen // 追加
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, isModalDisplayed: $isModalDisplayed)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        @Binding var isModalDisplayed: Bool

        init(_ parent: ImagePicker, isModalDisplayed: Binding<Bool>) {
            self.parent = parent
            self._isModalDisplayed = isModalDisplayed
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
                parent.isPresented = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isModalDisplayed = true
                }
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
            self.isModalDisplayed = false
        }
    }
}

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @Environment(\.colorScheme) var colorScheme
    @State private var isUserModalPresented = false
    @State private var UploadedImageModal = false
    @State private var isImagePickerDisplayed = false
    @State private var image: UIImage? = nil
    @State private var isModalDisplayed = false
    @State private var userInfo: UserInfo?
    
    var body: some View {
        NavigationView {
            VStack {
                    Button("画像を選択") {
                        vibration()
                        isImagePickerDisplayed = true
                    }
                    .padding(.horizontal, 15) // 左右
                    .padding(.vertical, 10) // 上下
                    .background(Color(colorScheme == .dark ? .white.opacity(0.1) : .white))
                    .cornerRadius(15)
                    .foregroundColor(.primary)
                    .shadow(color: Color(colorScheme == .dark ? .white : .black.opacity(0.3)), radius: 10, x: 0, y: 5)
                    .font(.system(size: 25).bold())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                Button("アップロードした写真") {
                    UploadedImageModal.toggle()
                    vibration()
                }
                .shadow(color: Color(colorScheme == .dark ? .white : .black), radius: 13, x: 0, y: 0)
                .font(.system(size: 18).bold())
                .padding()
                .sheet(isPresented: $UploadedImageModal) {
                    PictureModalView()
                        .edgesIgnoringSafeArea(.all)
                        .presentationDetents([.large, .height(200), .fraction(0.5)])
                }
            }
            .sheet(isPresented: $isImagePickerDisplayed) {
                ImagePicker(isPresented: $isImagePickerDisplayed, image: $selectedImage, isModalDisplayed: $isModalDisplayed)
            }
            .sheet(isPresented: $isModalDisplayed) {
                UpLoadingImage(selectedImage: $selectedImage, isModalDisplayed: $isModalDisplayed)
            }
            .navigationBarItems(trailing:
                HStack {
                    if let userInfo = userInfo {
                    Button(action: {
                        vibration()
                        isUserModalPresented.toggle()
                    }) {
                        if let url = URL(string: userInfo.profile_photo_url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill() // Change this line
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle()) // Move this line up
                                    .padding(10)
                            } placeholder: {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFill() // Change this line
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle()) // Move this line up
                                    .padding(10)
                            }
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .cornerRadius(15)
                                .padding(10)
                        }
                    }
                    .sheet(isPresented: $isUserModalPresented) {
                        UserPageView()
                            .edgesIgnoringSafeArea(.all)
                            .presentationDetents([.large, .height(400), .fraction(0.5)])
                    }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(15)
                            .padding(10)
                    }
                }
            )
            .navigationTitle("Image Tokuly")
            }
        .onAppear {
            loadUserInfo { userInfo in
                self.userInfo = userInfo
            }
        }
    }
}

func loadUserInfo(completion: @escaping (UserInfo?) -> Void) {
    guard let token = UserDefaults.standard.string(forKey: "Token") else {
        print("Token not found")
        completion(nil)
        return
    }
    print(token)
    let url = URL(string: "https://api.tokuly.com/auth/session")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    let bodyParameters = "token=\(token)"
    request.httpBody = bodyParameters.data(using: .utf8)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response: (httpResponse)")
            }
            
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: " + jsonString)
            } else {
                print("Invalid JSON data")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UserInfo.self, from: data)
                completion(decodedResponse)
            } catch {
                print("Error decoding: \(error)")
                completion(nil)
            }
        }
    }.resume()
}


struct UpLoadingImage: View {
    @Binding var selectedImage: UIImage?
    @Binding var isModalDisplayed: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("この写真をアップロードしますか？")
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    isModalDisplayed = false
                }) {
                    Text("キャンセル")
                },
                trailing: Button(action: {
                    vibration2()
                }) {
                    Text("アップロード")
                }
            )
        }
        .onDisappear {
            selectedImage = nil
        }
    }
}


struct PictureModalView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("まだアップロードしてないらしい...")
            .padding()
            .foregroundColor(.primary)
            .shadow(color: Color(colorScheme == .dark ? .white : .black).opacity(0.3), radius: 20, x: 0, y: 5)
    }
}

extension UIImagePickerController {
    func present() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        rootViewController.present(self, animated: true, completion: nil)
    }
}

func vibration() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    generator.impactOccurred()
}

func vibration2() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserInfo: Codable {
    var name: String
    var handle: String
    var profile_photo_url: String
}

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            Text("ImageTokuly")
                .font(.system(size: 30).bold())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: LaunchScreenView())
        self.window = window
        window.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            window.rootViewController = UIHostingController(rootView: ContentView())
        }

        return true
    }
}
