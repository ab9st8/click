# Click—and it's done.
Click is a simple build tool for C. One command, `click`, and your code is compiled. You can even customize your build via a YAML file. Awesome, right? Ready to begin?

## Installation
**This section is still to be written; Click is not yet usage-ready. I'll finish 1.0 around 1th of July, maybe earlier.**

## Customisation
**Customising is not yet implemented, but will be soon. Therefore the following docs.**

To generate a Click configuration file, run:
```shell
click init
```
This will generate a `click.yaml` file with the following customisable fields:
* `compiler`—what C compiler Click should use. `clang` by default,
* `outputDir`—to which directory Click should output your executable. `./build/` by default,
* `auxOutput`—whether Click should output cool info like the number of C files it found and what command it's running. Set to `false` to disable that kind of output. Sometimes silence is important. `true` by default.
