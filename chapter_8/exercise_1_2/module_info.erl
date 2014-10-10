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

dict_function_count() ->
  function_count(dict).

largest_exporter() ->
  modules_from_tuple_list(code:all_loaded()).

function_count(Mod) ->
  list_length(Mod:module_info(exports), 0).

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
