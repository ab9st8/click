import yaml/serialization, streams, os, terminal, strutils

## This type represents the Click configuration.
type
  ClickConfig = object
    compiler, outputDir: string
    auxOutput: bool
    ignoreDirs, ignoreFiles: seq[string]

## Compile all C files found in the workspace.
proc compile*(fromFile: bool) =
  var config: ClickConfig = ClickConfig(
    compiler: "clang",
    outputDir: "./build/",
    auxOutput: true,
    ignoreDirs: @[".vscode/"],
    ignoreFiles: @[]
  )
  if fromFile:
    var stream = newFileStream("./click.yaml")
    load(stream, config)
    stream.close()
    # TODO: NORMALIZE EVERY PATH HERE
  var ignoreDirs: seq[string] = @[]
  var ignoreFiles: seq[string] = @[]
  
  # Normalize directory names
  for dir in config.ignoreDirs:
    ignoreDirs.add(dir.expandFilename())
  config.ignoreDirs = ignoreDirs

  # Normalize filenames
  for file in config.ignoreFiles:
    ignoreFiles.add(file.expandFilename())
  config.ignoreFiles = ignoreFiles



  var inputFiles: seq[string] = @[]
  var command = "echo You shouldn't see this! Something went wrong!\nStart an issue (https://github.com/aachh/click/issues) if you're seeing this. && exit 1"

  for file in walkDirRec("./"):
    if config.ignoreFiles.contains(file.expandFilename()):                continue # First check if we should ignore this file
    if config.ignoreDirs.contains(splitPath(file).head.expandFilename()): continue # Then check if we should ignore this directory

    if file[^2..^1] == ".c":
      echo(file)
      inputFiles.add(file)

  if inputFiles.len() == 0:
    echo("Hmm… are you sure this is a C project? I couldn't find any C files and therefore wasn't able compile them. 😕")
    quit(1)
  
  let outputFile = config.outputDir / getCurrentDir().lastPathPart() # Not division; path joining. Pretty sick.
  
  command = config.compiler & " " & inputFiles.join(" ") & " -o " & outputFile

  if config.auxOutput:
    stdout.styledWrite(styleBright, "Found " & intToStr(inputFiles.len()) & " C files!\nCompiling...\n", resetStyle, styleDim, "$ " & command & "\n\n", resetStyle)
  
  let exitCode = execShellCmd(command)
  quit(exitCode)