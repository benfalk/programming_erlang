-module(group_monitor).
-export([start/1]).

start(FunList) ->
  spawn(fun()->
    [spawn_restarter(Fun) || Fun <- FunList]
    end
  ).

spawn_restarter(Fun) ->
  Pid = spawn(Fun),
  io:format("Started up ~p~n", [Pid]),
  on_exit(Pid, fun()-> spawn_restarter(Fun) end),
  Pid.

on_exit(Pid, Fun) ->
  spawn(fun()->
    Ref = monitor(process, Pid),
    receive
      {'DOWN', Ref, process, Pid, _} -> 
        io:format("Pid died: ~p, respawning~n", [Pid]),
        Fun()
    end
  end).
