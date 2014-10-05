Programming Erlang: Software for a Concurrent World (Exercises)
===============================================================

This is a collection of exercises that I have completed from
[this book](http://goo.gl/xYyQ0d).  Each chapter I have done is in a seperate
directory, such as `chapter_1` etc.  I also plan to put notes in markdown
format that I pick up along the way in each chapter.  Eventually the more
important notes will be found in this readme.

Chapter 5 Issues
----------------

The following methods are said to exist in R17 of Erlang but do not:

* maps:to_json(Map) -> Bin
* maps:from_json(Bin) -> Map
* maps:safe_from_json(Bin) -> Map

There does not seem to be any native way to convert json to erlang maps; which
is a big issue for exercise one of chapter five.  The confusion seems to come
between people believing it should not be a core feature of the language.
