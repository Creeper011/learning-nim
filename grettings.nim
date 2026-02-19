# reference script: grettings.sh

import std/[times, os]

proc getGrettingByTime(): string =
    let hour = now().hour
    case hour:
    of 0..11: "Morning"
    of 12..17: "Afternoon"
    else: "Evening"

proc parseOutput(): string =
    let args = commandLineParams()
    let grettings = getGrettingByTime()
    let name =
        if args.len > 0:
            args[0] & "!"
        else:
            ""
    "Good " & grettings & " " & name
  
echo parseOutput()