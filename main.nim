# Say Hello
# Customizable Hello World by changing "World" to a custom variable
import os

proc parseOutput(): string =
    let args = commandLineParams()
    let name =
        if args.len > 0:
            args[0]
        else:
            "World"
    "Hello, " & name
  
echo parseOutput()