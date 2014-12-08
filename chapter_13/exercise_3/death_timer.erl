-module(death_timer).
-export([my_spawn/3,my_spawn/1]).

my_spawn(Mod, Func, Args) ->
  Pid = spawn(Mod, Func, Args),
  kill_after(Pid, 15000),
  Pid.

my_spawn(Fun) ->
  Pid = spawn(Fun),
  kill_after(Pid, 15000),
  Pid.

kill_after(Pid, Time) ->
  spawn(fun()->
    Ref = monitor(process, Pid),
    receive
      {'DOWN', Ref, process, Pid, _} -> void
      after Time -> 
        io:format("Pid ~p being killed, exceded max time of ~p seconds~n",[Pid, Time/1000]),
        exit(Pid, kill)
    end
  end).
