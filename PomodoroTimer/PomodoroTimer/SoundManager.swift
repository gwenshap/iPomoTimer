import Foundation
import AudioToolbox

class SoundManager {
    static let shared = SoundManager()
    
    enum SoundType {
        case startWork
        case startBreak
        case timerComplete
        
        var systemSoundID: SystemSoundID {
            switch self {
            case .startWork:
                return 1035
            case .startBreak:
                return 1024
            case .timerComplete:
                return 1005
            }
        }
    }
    
    private init() { }
    
    func playSound(_ sound: SoundType) {
        AudioServicesPlaySystemSound(sound.systemSoundID)
    }
    
    func playAlertSound(_ sound: SoundType) {
        AudioServicesPlayAlertSoundWithCompletion(sound.systemSoundID) {
            // Vibrate the device for additional feedback
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
}
