 import SwiftUI

struct ContentView: View {
    @State private var message = "Welcome to MyApp!"

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "hand.wave.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Welcome to MyApp")
                .font(.largeTitle)
                .bold()

            Text(message)
                .font(.title3)

            Button("Get Started") {
                message = "You have successfully started the app!"
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}