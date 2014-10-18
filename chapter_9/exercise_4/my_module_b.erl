-module(my_module_b).

-export([increase_age/1]).
-export([default_person/0]).
-export([test/0]).

increase_age({G, A, N}) -> {G, A+1, N}.
default_person() -> my_module_a:new_person(male, 21, benjamin).
test() ->
  Person = default_person(),
  {male, 22, benjamin} = increase_age(Person),
  tests_passed.
