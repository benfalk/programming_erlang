-module(ring_master).
-export([
  chain_talker/0,
  chain_talker/1,
  build/0,
  build/1
]).

%loop(WorkerCount) ->
  %loop(WorkerCount, 1).

%loop(WorkerCount, Times) ->
  %Workers = spawn_workers(WorkerCount).

%spawn_workers(WorkerCount) ->
  %First = chain_talker(),
  %spawn_next(1, WorkerCount, []).

build() ->
  spawn(ring_master, chain_talker, []).

build(Process) ->
  spawn(ring_master, chain_talker, [Process]).

chain_talker() ->
  receive
    {link, Process} -> chain_talker(Process);
    Any -> io:format("Error, not linked: ~p",[Any])
  end.

chain_talker(Process) ->
  receive
    {msg, Message} -> Process ! {msg, Message},
                      io:format("Got Message: ~p~n",[Message]),
                      chain_talker(Process)
  end.
