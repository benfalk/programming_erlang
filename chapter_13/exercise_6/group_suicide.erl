-module(group_suicide).
-export([
  create_watch/1
]).

create_watch(FunList) ->
  spawn(fun()->
    PidRefs = [spawn_monitor(Fun) || Fun <- FunList],
    watch(PidRefs, FunList)
  end).

watch(PidRefs, FunList) ->
  receive
    {'DOWN', Ref, process, Pid, _} ->
      io:format("Got it going down~n",[]),
      case find_any({Pid,Ref}, PidRefs) of
        false -> watch(PidRefs, FunList);
        true  -> io:format("It's going down",[]),
                   [exit(KillPid, kill) || {KillPid,_} <- PidRefs],
                   create_watch(FunList)
      end
  end.

find_any(_, []) -> false;
find_any(PidRef, [{Pid,Ref}|T]) ->
  case PidRef of
    {Pid,Ref} -> true;
    _         -> find_any(PidRef, T)
  end.
