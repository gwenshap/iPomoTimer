import Foundation
import SwiftUI

enum TimerMode: String {
    case work = "Work"
    case shortBreak = "Short Break"
    case longBreak = "Long Break"
}

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isActive = false
    @Published var currentMode: TimerMode = .work
    @Published var completedWorkSessions = 0
    
    private var timer: Timer?
    private let workTime = 25 * 60  // 25 minutes in seconds
    private let shortBreakTime = 5 * 60  // 5 minutes in seconds
    private let longBreakTime = 15 * 60  // 15 minutes in seconds
    
    // Reference to the sound manager singleton
    private let soundManager = SoundManager.shared
    
    init() {
        self.timeRemaining = workTime
    }
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func start() {
        guard !isActive else { return }
        isActive = true
        
        // Play start sound based on current mode
        switch currentMode {
        case .work:
            soundManager.playSound(.startWork)
        case .shortBreak, .longBreak:
            soundManager.playSound(.startBreak)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, self.timeRemaining > 0 else {
                self?.playTimerCompleteSound()
                self?.cycleToNextMode()
                return
            }
            self.timeRemaining -= 1
        }
    }
    
    func pause() {
        isActive = false
        timer?.invalidate()
    }
    
    func reset() {
        pause()
        setTimerForCurrentMode()
    }
    
    private func playTimerCompleteSound() {
        // Play timer complete sound with alert and vibration
        soundManager.playAlertSound(.timerComplete)
    }
    
    private func cycleToNextMode() {
        pause()
        
        switch currentMode {
        case .work:
            completedWorkSessions += 1
            if completedWorkSessions % 4 == 0 {
                currentMode = .longBreak
            } else {
                currentMode = .shortBreak
            }
        case .shortBreak, .longBreak:
            currentMode = .work
        }
        
        setTimerForCurrentMode()
        start()
    }
    
    private func setTimerForCurrentMode() {
        switch currentMode {
        case .work:
            timeRemaining = workTime
        case .shortBreak:
            timeRemaining = shortBreakTime
        case .longBreak:
            timeRemaining = longBreakTime
        }
    }
}
