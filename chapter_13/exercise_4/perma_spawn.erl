-module(perma_spawn).
-export([keep_alive_on/2]).

keep_alive_on(Atom, Fun) ->
  Pid = spawn(Fun),
  register(Atom, Pid),
  on_exit(Pid, fun()-> keep_alive_on(Atom, Fun) end),
  heartbeat(Atom, Pid).

on_exit(Pid, Fun) ->
  spawn(fun()->
    Ref = monitor(process, Pid),
    receive
      {'DOWN', Ref, process, Pid, _} -> Fun()
    end
  end).

heartbeat(Atom, Pid) ->
  spawn(fun()->
    Ref = monitor(process, Pid),
    heartbeat(Atom, Ref, Pid)
  end).

heartbeat(Atom, Ref, Pid) ->
  io:format("Process is alive: ~p~n", [Atom]),
  receive
    {'DOWN', Ref, process, Pid, Why} -> io:format("Process died: ~p [~p]~n", [Atom, Why])
    after 5000 -> heartbeat(Atom, Ref, Pid)
  end.
    
    
