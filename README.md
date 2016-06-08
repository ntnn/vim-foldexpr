vim-foldexpr adds folding expressions for various filetypes.

While there is fold-syntax, it can be slow and is often non-existent, since
it relies on the "fold" argument on the syntax groups.

Also, some filetypes require special expressions for foldtext. The default
might be enough for, but sometimes the first line of the fold is not giving
the required information.

Example:
```py
@decorator
def method():
    return 1
```

Would turn into this fold:

```vim
+-- 3 lines: @decorator
```

Which doesn't yield much information on its contents.
