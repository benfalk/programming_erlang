% Write a function map_search_pred(Map, Pred) that returns the first element
% {Key, Value} in the map for which Pred(Key, Value) is true.

-module(my_map).
-export([map_search_pred/2]).

map_search_pred(Map, Pred) ->
  find_first(maps:to_list(Map), Pred).

find_first([], _) -> nil;

find_first([{Key, Value}|T], Pred) ->
  case Pred(Key, Value) of
    true -> {Key, Value};
    _    -> find_first(T, Pred)
  end.
