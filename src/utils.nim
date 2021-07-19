import terminal, sugar

using
    s: string
    newline: bool

## Success messages.
proc writeSuccess*(s, newline) =
    stdout.styledWrite(fgCyan, s)
    if newline: stdout.write("\n")

## Important messages and prompts.
proc writePrompt*(s, newline) =
    stdout.styledWrite(styleBright, s)
    if newline: stdout.write("\n")

## Error messages.
proc writeError*(s, newline) =
    stdout.styledWrite(fgRed, s)
    if newline: stdout.write("\n")

## Auxiliary output.
proc writeAux*(s, newline) =
    stdout.styledWrite(styleDim, s)
    if newline: stdout.write("\n")

## A for-each proc.
proc forEach*[T](arr: var openArray[T], f: (T) -> T) =
    for el in arr.mitems(): el = f(el)

## Normalises configuration fields by
## checking for existence of directories and files
## and expanding their paths to be absolute.
template normalise*(field: untyped, existsProc: untyped): untyped =
    var field: seq[string] = @[]
    for el in config.field:
        if not existsProc(workspace / el): continue
        field.add(workspace / el)
    config.field = field