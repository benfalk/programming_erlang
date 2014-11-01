% Rewrite the code in try_test.erl so that it produces two error messages: a
% polite message for the user and a detailed message for the developer.

-module(try_test).
-export([generate_exception/1]).
-export([demo1/0]).


demo1() ->
  [catcher(I) || I <- [1,2,3,4,5]].

generate_exception(1) -> a;
generate_exception(2) -> throw(maps:to_list(#{
  polite   => {"2 isn't that greate", a},
  detailed => {"2 is the only prime", erlang:get_stacktrace(), a}}));
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).

catcher(N) ->
  try generate_exception(N) of
    Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X  -> {N, caugth, exited, X};
    error:X -> {N, caught, error, X}
  end.
