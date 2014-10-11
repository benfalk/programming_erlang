% 1. Reread the section about Mod:module_info() in this chapter.  Give the
% command dict:module_info().  How many functions does this module return?

% 2. The command code:all_loaded() returns a list of {Mod,File} pairs of all
% modules that have been loaded into the Erlang system.  Use the BIF
% Mod:module_info() to find out about these modules.  Write functions to
% determine which module exports the most functions and which function name is
% the most common.  Write a function to find all unambiguous function names,
% that is, funciton names that are used in only one module.

-module(module_info).
-export([dict_function_count/0]).
-export([largest_exporter/0]).
-export([function_map/0]).
-export([most_common_function/0]).

dict_function_count() ->
  function_count(dict).

largest_exporter() ->
  Modules = modules_from_tuple_list(code:all_loaded()),
  ModuleCounts = [{Module,function_count(Module)} || Module <- Modules],
  largest_module(ModuleCounts).

most_common_function() ->
  Functions = maps:to_list(function_map()),
  largest_module(Functions, {nil,0}).

function_count(Mod) ->
  list_length(Mod:module_info(exports), 0).

function_map() ->
  Modules = modules_from_tuple_list(code:all_loaded()),
  Functions = lists:flatten(lists:map(fun(M) -> M:module_info(exports) end, Modules)),
  map_functions(Functions, #{}).

map_functions([], Map) -> Map;
map_functions([H|T], Map) ->
  {Method,_} = H,
  Count = get(Method, Map, 0),
  map_functions(T, maps:put(Method, Count+1, Map)).


list_length([], N) -> N;
list_length([_|T], N) ->
  list_length(T, N+1).

modules_from_tuple_list([]) -> [];

modules_from_tuple_list([H|T]) ->
  {Mod,_} = H,
  modules_from_tuple_list(T,[Mod]).

modules_from_tuple_list([], L) -> L;

modules_from_tuple_list([H|T], L) ->
  {Mod,_} = H,
  modules_from_tuple_list(T,[Mod|L]).

largest_module([]) -> [];
largest_module(L) ->
  largest_module(L, {nil,0}).

largest_module([], Result) -> Result;
largest_module([H|T], {Mod,Size}) ->
  {CheckMod,CheckSize} = H,
  case CheckSize >= Size of
    true -> largest_module(T, {CheckMod,CheckSize});
    false -> largest_module(T, {Mod,Size})
  end.

% My implementation doesn't have default for maps :sad-trumpet:
get(Key, Map, Default) ->
  try maps:get(Key, Map) of
    Val -> Val
  catch
    _:_ -> Default
  end.
