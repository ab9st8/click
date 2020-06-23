# Click—and it's done.
Click is a simple build tool for C. One command, `click`, and your code is compiled. You can even customize your build via a YAML file. Awesome, right? Ready to begin?

## Installation
Click isn't yet available on any major package managers, but it's absolutely okay to build from source. To actually do that, make sure you have Nim and Nimble installed. Then:
```shell
git clone https://github.com/aachh/click.git # clone the repository...
cd click                                     # ...go to the project...
nimble build                                 # ...and build it!
```
Click will appear in the `build` directory. Then just place it on your `$PATH`, wherever you want to.

## Customisation
To generate a Click configuration file, run:
```shell
click init
```
This will generate a `click.yaml` file with the following customisable fields:
* `compiler`—what C compiler Click should use. `clang` by default,
* `outputDir`—to which directory Click should output your executable. `./build/` by default,
* `auxOutput`—whether Click should output cool info like the number of C files it found and what command it's running. Set to `false` to disable that kind of output. Sometimes silence is important. `true` by default.

If you want to revert to the defaults, just run `click init` again. It's that simple.