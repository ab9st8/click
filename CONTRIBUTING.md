Hey! I'm very excited with the fact that you want to work on Click. Let's make this little tool the best it can be, together.

Here is some info you need to know before you contribute:

## For code contributors
If you're committing code in the context of an existing issue, make sure to reference it. Please write readable code (it's not that hard!). A comment on comments (pun intended 😛): when writing a proc, summarize what it does before its definition with a comment block **beginning with two hashes,** like this:
```nim
## Sum two numbers. When both of the parameters
## are negative, we can expect a negative result.
proc sum(a: int, b: int): int =
    result = a + b
```
That makes it easier to write and read multi-line documentation. Beyond that, whenever there's some code that may be tricky to understand, complement it with a simple one-line (or inline) summary comment. Other than that, there's one more rule: have fun!

## For feature requesters
Before you grace us with your wonderful idea (which it definitely is, not kidding), make sure you fill out this simple field:

**Type: [one of `bug`, `major bug`, `feature`, or `major feature`]**

In case of `bug` please also include:

**OS: [one of `macOS`, `Windows`, `Linux`, `other`, or `any` in case of platform-agnostic bug]**

This makes it easier to prioritize issues for the code contributors. Obviously major bugs will be looked at first, then bugs, then features and then major features. Please make sure fill in both the "type" field in the issue body as well as the appropriate label. Let's keep things organized, please.

(_Why "features" before "major features?"_ Major features make us think about redesigning the tool which takes more time. Therefore we can let ourselves take more time with them. Smaller features are easier to implement and thus will be delivered faster. 👍🏻 Don't worry, everything's looked at sooner or later!)

