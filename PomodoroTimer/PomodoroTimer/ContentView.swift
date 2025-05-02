import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        ZStack {
            // Background color changes based on timer mode
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Title
                Text(timerManager.currentMode.rawValue)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                // Circular progress indicator
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.1)
                        .foregroundColor(.white)
                    
                    // Progress circle
                    Circle()
                        .trim(from: 0.0, to: progressValue)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear(duration: 1.0), value: progressValue)
                    
                    // Time remaining
                    Text(timerManager.timeString)
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 280, height: 280)
                
                // Completed sessions
                HStack {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .fill(index < timerManager.completedWorkSessions % 4 ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.top, 10)
                
                // Control buttons
                HStack(spacing: 30) {
                    controlButton(
                        title: timerManager.isActive ? "Pause" : "Start",
                        icon: timerManager.isActive ? "pause.fill" : "play.fill",
                        color: timerManager.isActive ? .orange : .green
                    ) {
                        if timerManager.isActive {
                            timerManager.pause()
                        } else {
                            timerManager.start()
                        }
                    }
                    
                    controlButton(
                        title: "Reset",
                        icon: "arrow.counterclockwise",
                        color: .red
                    ) {
                        timerManager.reset()
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
    
    // Helper for calculating progress
    private var progressValue: CGFloat {
        let totalTime: CGFloat
        switch timerManager.currentMode {
        case .work:
            totalTime = 25 * 60
        case .shortBreak:
            totalTime = 5 * 60
        case .longBreak:
            totalTime = 15 * 60
        }
        
        return CGFloat(timerManager.timeRemaining) / totalTime
    }
    
    // Helper for background color
    private var backgroundColor: Color {
        switch timerManager.currentMode {
        case .work:
            return Color.red.opacity(0.8)
        case .shortBreak:
            return Color.green.opacity(0.7)
        case .longBreak:
            return Color.blue.opacity(0.7)
        }
    }
    
    // Helper for creating control buttons
    private func controlButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .frame(width: 80, height: 80)
            .background(color)
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
