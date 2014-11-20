% Write a function start(AnAtom, Fun) to register AnAtom as spawn(Fun). Make
% sure your program works correctly in the case when two parallel processes
% simultaneously evaluate start/2. In this case, you must guarantee that one
% of these processes succeeds and the other fails.

-module(lib_misc).
-export([start/2]).

start(AnAtom, Fun) ->
  true = register(AnAtom, spawn(Fun)).
