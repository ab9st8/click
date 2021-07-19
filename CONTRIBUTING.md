Hey! I'm very excited about the fact that you want to work on Click. Let's make this little tool the best it can be, together.

Here is some info you need to know before you contribute:

## For code contributors

If you're committing code in the context of an existing issue, make sure to reference it.

When writing a proc, summarize what it does before its definition with a comment block **beginning with two hashes,** like this:

```nim
## Returns the n-th Fibonacci number.
proc fibonacci(n: int): int =
    if n == 1: return 1
    else: return n * fibonacci(n - 1)
```

That makes it easier to write and read multi-line documentation. Beyond that, whenever there's some code that might be tricky or hard to understand at first, complement it with a simple one-line (inline or not) summary comment.

If a proc should not cause any side effects, switch `proc` with `func` in the definition. That is equivalent to adding the `{.noSideEffects.}` pragma.

## For feature requesters

When creating an issue, please attach the respective labels to it. You should attach (one from every bullet point):

-   "major bug", "bug", "feature" or "major feature",
-   "Windows", "Linux", "macOS", or none (in case of system-agnostic issues),
-   "question" or none,
-   "documentation" or none.

This makes it easier to prioritize issues for code contributors. Major bugs will be looked at first, then bugs, then features, and lastly major features.

### Why "features" before "major features?

Major features make us think about redesigning the tool which takes more time. Therefore we can let ourselves take more time with them. Smaller features are easier to implement and thus will be delivered faster. Don't worry, everything's looked at sooner or later!
