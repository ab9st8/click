import os, strutils

## TODO ##
const HELP_MSG = "hemlo. help here."

proc compile(fromFile: bool) =
  # Names of the files to compile.
  var inputFiles: seq[string] = @[]
  # Compiler to use.
  var compiler = "clang"
  # The resulting output executable.
  var outputFile = "./build/" / getCurrentDir().lastPathPart() # Not division; path joining.

  # The complete command.

  for file in walkDirRec("./"):
    if file[^2..^1] == ".c":
      inputFiles.add(file)
  
  if inputFiles == @[]:
    echo "Hmm... are you sure this is a C project? I couldn't find and C files and therefore wasn't able compile them. 😕"

  var command = compiler & " " & inputFiles.join(" ") & " -o " & outputFile
  
  echo("input files:")
  echo(inputFiles)
  echo("compiler:\n" & compiler)
  echo("output file:\n" & outputFile & "\n")

  echo("COMMAND:\n" & command)


  # if not fromFile: # compile with default parameters
  #   discard execShellCmd("echo hello")
    

## TODO ##
proc initialize(reinitialize: bool) =
  echo "albalbalb"

when isMainModule:
  let configExists = existsFile(".solo.yaml")
  case paramCount():
    of 0:
       compile(configExists)
    of 1:
      case paramStr(1):
        of "init":
          initialize(configExists)
        # You'd expect I'd cover a seperate `of "help` case,
        # but no. We show the help message whenever an
        # unknown command is used, including `help`.
        else:
          echo(HELP_MSG)
    else:
      echo(HELP_MSG)
