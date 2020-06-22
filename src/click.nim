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
  
  if inputFiles.len() == 0:
    echo("Hmm... are you sure this is a C project? I couldn't find any C files and therefore wasn't able compile them. 😕")
    quit(1)


  if not fromFile: # compile with default parameters
    compiler = "clang"
    outputFile = "./build/" / getCurrentDir().lastPathPart()
    var command = compiler & " " & inputFiles.join(" ") & " -o " & outputFile
    discard execShellCmd(command)
    quit(0) # not sure if there's a better way to do this
  else:
    echo("Reading from YAML file not implemented yet!")
    

## TODO for 0.2 ##
proc initialize(reinitialize: bool) =
  discard


######################################


when isMainModule:
  let configExists = existsFile("click.yaml")
  case paramCount():
    of 0:
       compile(configExists)
    of 1:
      case paramStr(1):
        of "init":
          initialize(configExists)
        # You'd expect I'd cover a seperate `of "help"` case,
        # but no; we show the help message whenever an
        # unknown command is used, including "help."
        else:
          echo(HELP_MSG)
    else:
      echo(HELP_MSG)
