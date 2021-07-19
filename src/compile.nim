import toml_serialization, os, strutils, utils, initialize, sugar

## Represents the Click configuration, corresponds to the TOML fields.
type
    ClickConfig* = object
        name, compiler, outputDir: string
        auxOutput: bool
        extensions, ignoreDirs, ignoreFiles, flags, libs, includes, linkDirs: seq[string]

## Handles the file-finding in a single directory
## and passes it on to subdirectories recursively.
## Returns all the .c files found in workspace.
proc handleDirectory(dir: string, ignoreFiles: seq[string], ignoreDirs: seq[string], extensions: seq[string]): seq[string] =
    for kind, name in walkDir(dir):
        if kind == pcFile:
            if ignoreFiles.contains(name): continue
            elif name.checksExtension(extensions): result.add(name.expandFilename())
        elif kind == pcDir:
            if ignoreDirs.contains(name): continue
            else: result.add(handleDirectory(name, ignoreFiles, ignoreDirs, extensions))

## Compiles all files found in the workspace.
proc compile*(fromFile: bool, workspace: string) =
    var config: ClickConfig

    # Load the TOML configuration. If there isn't one, create it.
    if not fromFile:
        writePrompt("In order to Click this project, a `click.toml` file needs to be created. Proceed? [Y/n]", true)
        while true:
            let response = stdin.readLine()
            if response == "y" or response == "" or response == "yes":
                initialize(false, workspace)
                break
            elif response == "n" or response == "no":
                echo("Discarding.")
                return
            writeError("Please input either `y` or `n`.", true)

    var file = readFile(workspace / "click.toml")
    config = Toml.decode(file, ClickConfig)

    normalise(ignoreDirs, dirExists)
    normalise(ignoreFiles, fileExists)
    normalise(linkDirs, dirExists)
    normalise(includes, dirExists)

    var inputFiles = handleDirectory(workspace, config.ignoreFiles, config.ignoreDirs, config.extensions)

    config.libs.forEach((el) => "-l" & el)
    config.includes.forEach((el) => "-I" & el)
    config.linkDirs.forEach((el) => "-L" & el)

    if inputFiles.len() == 0:
        writePrompt("No files found that would match the provided extensions. Discarding.", true)
        quit(1)

    let outputFile = workspace / config.outputDir / config.name

    let command = config.compiler &
        " " & 
        config.flags.join(" ") &
        " " &
        inputFiles.join(" ") &
        " " &
        config.libs.join(" ") &
        (if config.libs != @[]: " " else: "") &
        config.includes.join(" ") &
        (if config.includes != @[]: " " else: "") &
        config.linkDirs.join(" ") &
        (if config.linkDirs != @[]: " " else: "") &
        "-o " & outputFile

    if config.auxOutput:
        writePrompt("Found " & intToStr(inputFiles.len()) & " files!\nCompiling...", true)
        writeAux("$ " & command & "\n", true) # double newline

    quit(execShellCmd(command))
