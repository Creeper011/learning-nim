# compare python scripts with nim scripts
import std/strutils
import osproc
import std/times

type
    File = object
        filename: string
        executionTime: float

type
    CompareFiles = object
        nimFile: File
        pythonFile: File

proc quitWhenEmpty(str: string) =
  if str.strip.len == 0:
    echo "filename cannot be empty"
    quit(1)

proc askAndGetFilenames(): CompareFiles =
    stdout.write("Nim filename (binary/compilated file): ") # this avoids from printing \n at the end
    stdout.flushFile()
    let nimFilename: string = readLine(stdin)

    stdout.write("Python filename: ")
    stdout.flushFile()
    let pythonFilename: string = readLine(stdin)

    quitWhenEmpty(pythonFilename)
    quitWhenEmpty(nimFilename)

    result.nimFile.filename = nimFilename
    result.pythonFile.filename = pythonFilename

proc compareExecutions(compareFiles: var CompareFiles) =
    let startPy = cpuTime()
    let pythonResult = execCmdEx("python " & compareFiles.pythonFile.filename)
    let endPy = cpuTime()
    
    if pythonResult.exitCode != 0:
        echo "Error executing Python script"
        quit(1)
    
    compareFiles.pythonFile.executionTime = endPy - startPy

    let startNim = cpuTime()
    let nimExecResult = execCmdEx("./" & compareFiles.nimFile.filename)
    let endNim = cpuTime()

    if nimExecResult.exitCode != 0:
        echo "Error executing Nim binary"
        quit(1)

    compareFiles.nimFile.executionTime = endNim - startNim

var data = askAndGetFilenames()
compareExecutions(data)

echo "\nResults:"
echo "Python: ", data.pythonFile.executionTime, "s"
echo "Nim:    ", data.nimFile.executionTime, "s"

if data.nimFile.executionTime < data.pythonFile.executionTime:
    let difference = data.pythonFile.executionTime / data.nimFile.executionTime
    echo "Nim was ", difference.formatFloat(ffDecimal, 2), "x faster than Python."