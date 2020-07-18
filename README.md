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
This will create a `click.yaml` file with the following customisable fields:
* `compiler`—what C compiler Click should use. `clang` by default,
* `outputDir`—to which directory Click should output your executable. `./build/` by default,
* `auxOutput`—whether Click should output cool info like the number of C files it found and what command it's running. Set to `false` to disable that kind of output. Sometimes silence is golden. `true` by default,
* `ignoreDirs`—what entire directories Click should omit in finding files to compile. `[".vscode"]` by default,
* `ignoreFiles`—what files Click should omit in finding files to compile. Empty by default.

If you want to revert to the defaults, just run `click init` again. It's that simple.

## Contributing
Contributions are very, very, _very_ welcome! If you have a feature request, create an issue. If you want to write some code, create a pull request. I've already created some issues so you can look into them if you want to first. But please read these two first!

---
### Info for contributors:

If you're committing code in the context of an existing issue, make sure to reference it. Please write readable code (it's not that hard!). A comment on comments (pun intended 😛): when writing a proc, summarize what it does before its definition **with two hashes.** That makes it easier to write and read multi-line documentation. Beyond that, whenever there's some code that may be tricky to understand, complement it with a simple one-line (or inline) summary comment.

---

### Info for feature requesters:

Before you grace us with your wonderful idea (which it definitely is, not kidding), make sure you fill out this simple field:

**Type: [one of `bug`, `major bug`, `feature`, or `major feature`]**

In case of bug also include:

**OS: [one of `macOS`, `Windows`, `Linux`, `other`, or `any` in case of platform-agnostic bug]**

This makes it easier to prioritize issues for the developers. Obviously major bugs will be looked at first, then bugs, then features and then major features. Please make sure fill in both the "type" field in the issue body as well as the appropriate label. Let's keep things organized, please.

(_Why "features" before "major features?"_ Major features make us think about redesigning the tool which takes more time. Therefore we can let ourselves take more time with them. Smaller features are easier to implement and thus will be delivered faster. 👍🏻 Don't worry, everything's looked at sooner or later!)


---

Lastly, thank you for using this little tool, or at least coming to this page! This means a lot to me!