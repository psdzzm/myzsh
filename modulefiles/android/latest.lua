local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : Android Development")
whatis("Description : Android SDK and NDK Toolkit")

local base = "/tools/JetBrains"

setenv("ANDROID_HOME", pathJoin(base, "Android", "Sdk"))
setenv("JAVA_HOME", pathJoin(base, "android-studio", "jbr"))

setenv("NDK_HOME", pathJoin(base, "Android", "Sdk", "ndk", "29.0.14206865"))

append_path("PATH", pathJoin(base, "Android", "Sdk", "emulator"))
append_path("PATH", pathJoin(base, "Android", "Sdk", "cmdline-tools", "latest", "bin"))
append_path("PATH", pathJoin(base, "Android", "Sdk", "platform-tools"))