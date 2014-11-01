% Advanced: Look up the manual pages for the Ruby hash class.  Make a module of
% the methods in the Ruby class that you think would be appropriate to Erlang.

-module(ruby_hash).
-export([each_pair/2]).
-export([invert/1]).
-export([reject/2]).
-export([select/2]).

each_pair(Map, Fun) ->
  run_through_sets(maps:to_list(Map), Fun),
  Map.

invert(Map) ->
  maps:from_list([{Value,Key} || {Key,Value} <- maps:to_list(Map)]).

reject(Map, Fun) ->
  Analyzed = [{Key,Value,Fun(Key,Value)} || {Key,Value} <- maps:to_list(Map)],
  maps:from_list([{Key,Value} || {Key,Value,false} <- Analyzed]).

select(Map, Fun) ->
  Analyzed = [{Key,Value,Fun(Key,Value)} || {Key,Value} <- maps:to_list(Map)],
  maps:from_list([{Key,Value} || {Key,Value,true} <- Analyzed]).

run_through_sets([], _) -> nil;
run_through_sets([{Key,Value}|T], Fun) ->
  Fun(Key, Value),
  run_through_sets(T, Fun).
