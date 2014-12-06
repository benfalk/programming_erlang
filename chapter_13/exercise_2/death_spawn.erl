-module(death_spawn).
-export([my_spawn/3,my_spawn/1]).

my_spawn(Mod, Func, Args) ->
  Pid = spawn(Mod, Func, Args),
  on_exit(Pid, fun(Why) -> io:format("Process died, reason: ~p~n", [Why]) end),
  Pid.

my_spawn(Fun) ->
  Pid = spawn(Fun),
  on_exit(Pid, fun(Why) -> io:format("Process died, reason: ~p~n", [Why]) end),
  Pid.

on_exit(Pid, Fun) ->
  spawn(fun()->
    Ref = monitor(process, Pid),
    receive
      {'DOWN', Ref, process, Pid, Why} -> Fun(Why)
    end
  end).
