# Click—and it's done.
Click is a simple build tool for C. One command, `click`, and your code is compiled. You can even customize your build via a YAML file. Awesome, right? Ready to begin?

## Installation
[Here](https://github.com/aachh/click/releases) you can download the latest release from GitHub (Linux not supported yet 😕), or you can build from source. To actually do the latter, make sure you have Nim and Nimble installed. Then:
```shell
git clone https://github.com/aachh/click.git # clone the repository...
cd click                                     # ...go to the project...
nimble build                                 # ...and build it!
```
Click will appear in the `build` directory. Then just place it on your `$PATH`, wherever that may be.

## Customisation
To generate a Click configuration file, run:
```shell
click init
```
(If you run just `click`, you will be prompted about creating this file nevertheless.) The resulting YAML file will have the following customisable fields:
* `name`—the name of your project. Your binary will be named this. `bin` by default,
* `compiler`—what C compiler Click should use. `clang` by default,
* `outputDir`—to which directory Click should output your executable. `./build/` by default,
* `auxOutput`—whether Click should output cool info like the number of C files it found and what command it's running. Set to `false` to disable that kind of output. Sometimes silence is golden. `true` by default,
* `ignoreDirs`—what entire directories Click should omit in finding files to compile. `[".vscode"]` by default,
* `ignoreFiles`—what files Click should omit in finding files to compile. Empty by default.

If you want to revert to the defaults, just run `click init` again. It's that simple.

## Contributing
Contributions are very, very, _very_ welcome! If you have a feature request, create an issue. If you want to write some code, create a pull request. I've already created some issues so you can look into them if you want to first.
For contributing info head on over to [CONTRIBUTING.md](CONTRIBUTING.md).

---

Lastly, thank you for using this little tool, or at least coming to this page! This means a lot to me!
