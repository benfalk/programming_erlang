-module(ring_master).
-export([
  build_chain/1,
  chain_talker/0,
  chain_talker/1,
  build/0,
  build/1,
  send_msg/1
]).

%loop(WorkerCount) ->
  %loop(WorkerCount, 1).

%loop(WorkerCount, Times) ->
  %Workers = spawn_workers(WorkerCount).

%spawn_workers(WorkerCount) ->
  %First = chain_talker(),
  %spawn_next(1, WorkerCount, []).

build_chain(Size) ->
  io:format("Building chain of size ~p~n", [Size]),
  Chain = build_chain(1, Size, build(self()), []),
  [First|_] = Chain,
  {Time,_} = timer:tc(ring_master, send_msg, [First]),
  io:format("Chain complete, took ~p microseconds~n",[Time]),
  [X ! die || X <- Chain],
  ok.


build_chain(Size, Size, P, L) -> [build(P)|L];
build_chain(N, Size, P, L) -> 
  Process = build(P),
  build_chain(N+1, Size, Process, [Process|L]).

build() ->
  spawn(ring_master, chain_talker, []).

build(Process) ->
  spawn(ring_master, chain_talker, [Process]).

chain_talker() ->
  receive
    {link, Process} -> chain_talker(Process);
    {msg, Message} -> io:format("Got Message: ~p~n", [Message]),
                      chain_talker();
    die            -> void
  end.

chain_talker(Process) ->
  receive
    {msg, Message} -> Process ! {msg, Message},
                      io:format("Got Message: ~p~n",[Message]),
                      chain_talker(Process);
    die            -> void
  end.

send_msg(Process) ->
  Process ! {msg, "Test"},
  receive
    {msg, Message} -> Message
  end.
