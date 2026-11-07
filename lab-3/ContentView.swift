import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            SwiftUIScreen()
                .tabItem {
                    Text("SwiftUI")
                }

            UIKitScreen()
                .tabItem {
                    Text("UIKit")
                }
        }
    }
}

struct SwiftUIScreen: View {

    @State private var name = ""
    @State private var result = "Your result will appear here"

    var body: some View {
        VStack(spacing: 20) {

            Text("SwiftUI Demo")
                .font(.largeTitle)
                .bold()

            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Show Result") {
                if name.trimmingCharacters(in: .whitespaces).isEmpty {
                    result = "Please enter your name"
                } else {
                    result = "Hello, \(name)!"
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(result)
                .font(.title3)
                .foregroundColor(.green)
        }
        .padding()
    }
}
class UIKitDemoView: UIView {

    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let showButton = UIButton(type: .system)
    let resultLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        titleLabel.text = "UIKit Demo"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect

        showButton.setTitle("Show Result", for: .normal)
        showButton.addTarget(self, action: #selector(showResult), for: .touchUpInside)

        
        resultLabel.text = "Your result will appear here"
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 18)
        resultLabel.numberOfLines = 0

        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(showButton)
        addSubview(resultLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            showButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            showButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 25),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    @objc func showResult() {

        let name = nameTextField.text ?? ""

        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            resultLabel.text = "Please enter your name"
        } else {
            resultLabel.text = "Hello, \(name)!"
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct UIKitScreen: UIViewRepresentable {

    func makeUIView(context: Context) -> UIKitDemoView {
        UIKitDemoView()
    }

    func updateUIView(_ uiView: UIKitDemoView, context: Context) {
    }
}

#Preview {
    ContentView()
}