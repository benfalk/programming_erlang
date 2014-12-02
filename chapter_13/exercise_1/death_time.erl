% Exercise 1.)  Write a function my_spawn(Mod, Func, Args) that behaves like
% spawn(Mod, Func, Args) but with one difference. If the spawned process dies,
% a message should be printed saying why the process died and how long the
% process lived for before it died

-module(death_time).
-export([my_spawn/3,sillyness/0,monit/0]).

my_spawn(Mod, Func, Args) ->
  Monitor = spawn(death_time, monit, []),
  Monitor ! {self(), Mod, Func, Args},
  receive
    {spawned, Pid} -> Pid
  end.

monit() ->
  receive
    {Host, Mod, Func, Args}  -> {Pid, _} = spawn_monitor(Mod, Func, Args),
                                Host ! {spawned, Pid},
                                wait_for_death()
  end.

wait_for_death() ->
  TimeStamp = os:timestamp(),
  receive
    {'DOWN',_,process,_,Why} -> io:format("Died: [~p]~nSeconds Lived: ~p~n",[Why,time_diff(TimeStamp,os:timestamp())]);
    _ -> io:format("Something fucked up happened~n", [])
  end.

sillyness() ->
  receive
    after 4000 -> void
  end.

time_diff({StartMega, StartSec, StartMicro}, {EndMega, EndSec, EndMicro}) when EndMicro > StartMicro ->
  {EndMega - StartMega, EndSec - StartSec, EndMicro - StartMicro};
time_diff({StartMega, StartSec, StartMicro}, {EndMega, EndSec, EndMicro}) ->
  {EndMega - StartMega, EndSec - StartSec - 1, EndMicro + 1000000 - StartMicro}.
