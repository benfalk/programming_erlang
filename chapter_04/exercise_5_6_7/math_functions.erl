% Exercise 5.
% Write a module called math_functions.erl exporting the functions even/1 and
% odd/1.  The function even(X) should return true if X is an even integer and
% otherwise false.  odd(X) should return true if X is an odd integer.

% Exercise 6.
% Add a higher-order function to math_functions.erl called filter(F, L), which
% returns all the elements X in L for which F(X) is true.

% Exercise 7.
% Add a function split(L) to math_functions.erl, which returns {Even, Odd}
% where Even is a lit of all the even numbers in L and Odd is a list of all the
% odd numbers in L.  Write this function in two different ways using
% accumulators and using the function filter you wrote in the previous exercise

-module(math_functions).
-export([even/1]).
-export([odd/1]).
-export([filter/2]).
-export([split_acc/1]).
-export([split_filter/1]).

even(X) -> X rem 2 =:= 0.
odd(X) -> X rem 2 =:= 1.

filter(F, L) -> [X || X <- L, F(X) =:= true].

split_acc(L) ->
  odds_and_evens_acc(L, [], []).

split_filter(L) ->
  Odd = fun(X) -> odd(X) end,
  Even = fun(X) -> even(X) end,
  {filter(Even, L), filter(Odd, L)}.

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;

odds_and_evens_acc([], Odds, Evens) -> {Evens, Odds}.
