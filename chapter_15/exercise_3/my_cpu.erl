-module(my_cpu).

-export([information/0]).

information()->
  Info = os:cmd("less /proc/cpuinfo"),
  io:format("Your cpu information:~n~s",[Info]).
