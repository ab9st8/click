import yaml/serialization, streams, os, terminal, strutils

## This type represents the Click configuration.
type
  ClickConfig = object
    compiler, outputDir: string
    auxOutput: bool

## Compile all C files found in the workspace.
proc compile*(fromFile: bool) =
  var config: ClickConfig = ClickConfig(
    compiler: "clang",
    outputDir: "./build/",
    auxOutput: true
  )
  if fromFile:
    var stream = newFileStream("./click.yaml")
    load(stream, config)
    stream.close()
  var inputFiles: seq[string] = @[]
  var command = "echo You shouldn't see this! Something went wrong!\nStart an issue (https://github.com/aachh/click/issues) if you're seeing this. && exit 1"
  for file in walkDirRec("./"):
    if file[^2..^1] == ".c":
      inputFiles.add(file)

  if inputFiles.len() == 0:
    echo("Hmm… are you sure this is a C project? I couldn't find any C files and therefore wasn't able compile them. 😕")
    quit(1)
  
  
  var outputFile = config.outputDir / getCurrentDir().lastPathPart() # Not division; path joining. Pretty sick.
  
  command = config.compiler & " " & inputFiles.join(" ") & " -o " & outputFile

  if config.auxOutput:
    stdout.styledWrite(styleBright, "Found " & inputFiles.len().intToStr() & " C files!\nCompiling...\n", resetStyle, styleDim, "$ " & command & "\n", resetStyle)
  
  discard execShellCmd(command)
  quit(0)