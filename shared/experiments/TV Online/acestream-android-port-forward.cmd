@rem %LOCALAPPDATA%\Android\Sdk\platform-tools\adb connect 127.0.0.1
@rem %LOCALAPPDATA%\Android\Sdk\platform-tools\adb -s 127.0.0.1:5555 forward tcp:6878 tcp:6878
@%LOCALAPPDATA%\Android\Sdk\platform-tools\adb -s emulator-5554 forward tcp:6878 tcp:6878
@%LOCALAPPDATA%\Android\Sdk\platform-tools\adb kill-server