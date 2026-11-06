import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var highScore = 0
    
    init() {
        _highScore = State(initialValue: UserDefaults.standard.integer(forKey: "HighScore"))
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05).ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("🏆 Điểm cao: \(highScore)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("\(tapCount)")
                        .font(.system(size: 90, weight: .heavy))
                        .monospacedDigit()
                }
                .padding(.top, 40)
                
                Spacer()
                
                Button(action: {
                    tapCount += 1
                    if tapCount > highScore {
                        highScore = tapCount
                        UserDefaults.standard.set(highScore, forKey: "HighScore")
                    }
                }) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.blue.opacity(0.8), .cyan.opacity(0.9)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 220, height: 220)
                        .shadow(color: .blue.opacity(0.4), radius: 15, x: 0, y: 8)
                        .overlay(
                            Text("TAP!")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
                .buttonStyle(ScaleButtonStyle())
                
                Spacer()
                
                Button(action: {
                    tapCount = 0
                }) {
                    Text("🔄 Đặt lại")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Capsule().stroke(Color.secondary.opacity(0.3), lineWidth: 1.5))
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}