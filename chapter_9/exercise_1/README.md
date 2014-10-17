Exercise One
============

Write some very small modules that export a single function. Write type
specifications for the exported functions. In the functions make some type
errors; then run the dialyzer on these programs and try to understand the
error messages. Sometimes you’ll make an error but the dialyzer will not
find the error; stare hard at the program to try to work out why you did
not get the error you expected.

Notes
-----

First time running dialyzer build cache with shell command:
```
dialyzer --build_plt --apps erts kernel stdlib
```

For this example, I was able to get the dialyzer to pass completely with:
```
dialyzer my_module_a.erl my_module_b.erl
```
