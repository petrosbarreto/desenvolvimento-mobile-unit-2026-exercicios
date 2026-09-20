flutter doctor -v
[√] Flutter (Channel stable, 3.47.1, on Microsoft Windows [versÆo 10.0.26200.9457], locale pt-BR) [215ms]
    • Flutter version 3.47.1 on channel stable at C:\Users\kaeza\Documents\Flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 6655482ec0 (4 weeks ago), 2026-08-19 10:07:23 -0700
    • Engine revision 5d53178869
    • Dart version 3.13.1
    • DevTools version 2.60.0
    • Feature flags: enable-web, enable-linux-desktop, enable-macos-desktop, enable-windows-desktop, enable-android, enable-ios, cli-animations, enable-native-assets, enable-record-use, enable-swift-package-manager, omit-legacy-version-file,
      enable-lldb-debugging, enable-uiscene-migration

[√] Windows Version (Windows 11 or higher, 25H2, 2009) [769ms]

[!] Android toolchain - develop for Android devices (Android SDK version 36.0.0) [436ms]
    • Android SDK at C:\Users\kaeza\AppData\Local\Android\sdk
    • Emulator version 37.1.11.0 (build_id 15917651) (CL:N/A)
    • Platform android-37.0, build-tools 36.0.0
    • Java binary at: C:\Program Files\Android\Android Studio\jbr\bin\java
      This is the JDK bundled with the latest Android Studio installation on this machine.
      To manually set the JDK path, use: `flutter config --jdk-dir="path/to/jdk"`.
    • Java version OpenJDK Runtime Environment (build 25.0.2+-15348964-b329.117)
    X Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/to/windows-android-setup for more details.

[X] Chrome - develop for the web (Cannot find Chrome executable at .\Google\Chrome\Application\chrome.exe) [15ms]
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.

[X] Visual Studio - develop Windows apps [13ms]
    X Visual Studio not installed; this is necessary to develop Windows apps.
      Download at https://visualstudio.microsoft.com/downloads/.
      Please install the "Desktop development with C++" workload, including all of its default components

[√] Connected device (3 available) [516ms]
    • SM S731B (mobile) • RQGL301KN8P • android-arm64  • Android 16 (API 36)
    • Windows (desktop) • windows     • windows-x64    • Microsoft Windows [versÆo 10.0.26200.9457]
    • Edge (web)        • edge        • web-javascript • Microsoft Edge 153.0.4234.32

[√] Network resources [687ms]
    • All expected network resources are available.

! Doctor found issues in 3 categories.

flutter --version
Flutter 3.47.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 6655482ec0 (4 weeks ago) • 2026-08-19 10:07:23 -0700
Engine • hash 11d79658c444477b06513d32b52c8c4ccb7276b0 (revision 5d53178869) (1 months ago) • 2026-08-18 23:36:01.000Z
Tools • Dart 3.13.1 • DevTools 2.60.0

flutter devices
Found 3 connected devices:
  SM S731B (mobile) • RQGL301KN8P • android-arm64  • Android 16 (API 36)
  Windows (desktop) • windows     • windows-x64    • Microsoft Windows [versÆo 10.0.26200.9457]
  Edge (web)        • edge        • web-javascript • Microsoft Edge 153.0.4234.32

Run "flutter emulators" to list and start any available device emulators.

If you expected another device to be detected, please run "flutter doctor" to diagnose potential issues. You may also try increasing the time to wait for connected devices with the "--device-timeout" flag. Visit https://flutter.dev/setup/ for
troubleshooting tips.