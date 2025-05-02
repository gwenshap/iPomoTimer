# Pomodoro Timer

A simple, elegant Pomodoro timer app for iOS built with SwiftUI.

<img src="https://github.com/gwenshap/iPomoTimer/raw/main/screenshot.png" height="500" >

## Features

- 📱 Clean, modern UI with SwiftUI
- ⏱️ Standard Pomodoro technique timing (25min work, 5min break, 15min long break)
- 🔄 Automatically cycles between work and break sessions
- 🔔 System sound notifications for session changes
- 📊 Visual progress tracking with circular progress indicator
- 🎨 Color changes based on current mode (work/break)
- 📱 Haptic feedback (vibration) when timer completes

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.0+

## Installation

1. Clone this repository
```bash
git clone https://github.com/yourusername/pomo.git
cd pomo
```

2. Open the project in Xcode
```bash
open PomodoroTimer/PomodoroTimer.xcodeproj
```

3. Build and run the app on your simulator or device

## Usage

1. Press the **Start** button to begin a Pomodoro work session (25 minutes)
2. The app will automatically transition to a short break (5 minutes) when the work session completes
3. After 4 work sessions, the app will give you a long break (15 minutes)
4. You can pause or reset the timer at any time

## Architecture

This app uses:
- **SwiftUI** for the user interface
- **Combine** for reactive state management
- **MVVM** architectural pattern
- **System sounds** for notifications

## Customization

You can easily customize the timer durations by modifying the constants in `TimerManager.swift`:

```swift
private let workTime = 25 * 60  // 25 minutes in seconds
private let shortBreakTime = 5 * 60  // 5 minutes in seconds
private let longBreakTime = 15 * 60  // 15 minutes in seconds
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The Pomodoro Technique® is a registered trademark of Francesco Cirillo
- Built with SwiftUI and ❤️
