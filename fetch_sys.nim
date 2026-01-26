import os
# WARNING: this only works on Linux

type 
    SystemData = object
        osType: string
        shellName: string
        graphicalBackend: string
        systemEnvironment: string
        username: string

func getSysInfo(): SystemData =
    result.osType = hostOS
    result.shellName = getEnv("SHELL", "unknown")
    result.graphicalBackend = getEnv("XDG_BACKEND", "unknown")
    result.systemEnvironment = getEnv("XDG_SESSION_DESKTOP", "unknown")
    result.username = getEnv("USER", "unknown")

let data = getSysInfo()

echo "OS type: " & data.osType
echo "Shell: " & data.shellName
echo "Session: " & data.graphicalBackend
echo "DE: " & data.systemEnvironment
echo "User: " & data.username