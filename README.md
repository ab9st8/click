# \*click* — done.
Click is a simple build tool for C. One command, `click`, and your code is compiled. The build command is customisable via a simple TOML configuration file.

## Installation
Releases are [under here.](https://github.com/c1m5j/click/releases) Preferably you can build from source. Make sure you have Nimble (and generally the Nim toolchain) installed. Then
```sh
git clone https://github.com/c1m5j/click.git # clone the repository...
cd click                                     # ...go to the project...
nimble build                                 # ...and build it!
```
Click will appear in the `build` directory. If it doesn't and something goes wrong, please [file an issue.](https://github.com/c1m5j/click/issues/new) Then just place it on your `$PATH`, wherever that may be.

## Customisation
To generate a Click configuration file, run:
```shell
click init
```
If you run Click without a configuration file you will be prompted about creating it nonetheless. The resulting TOML file will have the following customisable fields:
* `name` — the name of your project. Your binary will be named this. `bin` by default,
* `compiler` — what C compiler Click should use. `gcc` by default,
* `outputDir` — to which directory Click should output your executable. `./build` by default,
* `auxOutput` — whether Click should output auxiliary info like the number of C files it found and what command it's running. Set to `false` to disable that kind of output. `true` by default,
* `ignoreDirs` — what entire directories Click should omit in finding files to compile. Please make sure directory names **do not** end with a slash. `[".vscode"]` by default,
* `ignoreFiles` — what specific files Click should omit in finding files to compile. Empty by default,
* `flags` — what flags Click should pass to the compiler. `["-Wall"]` by default,
* `libs` — what static libraries Click should link during compilation with `-l<library>`. Empty by default,
* `includes` — what additional include directories Click should take into consideration during compilation with `-I<directory>`. Empty by default,
* `linkDirs` — what additional directories Click should link during compilation with `-L<library>`. Empty by default.

All paths **must** be relative to the workspace, e.g. with a project structure like this:
```
.
├── README.md
├── build
├── click.toml
└── src
    ├── main.c
    ├── utils.c
    └── include
        └── utils.h
```
...the include directory must be written as `"src/include"` in the configuration file.

If you want to revert to the defaults, just run `click init` again.

## Contributing
Contributions are very welcome! If you have a feature request, create an issue. If you want to write some code, create a pull request. There are already some issues open so you can look into them if you want to first.

For more specific contributing info head on over to [CONTRIBUTING.md](CONTRIBUTING.md).

---

Lastly, thank you for using this little tool, or at least coming to this page!
