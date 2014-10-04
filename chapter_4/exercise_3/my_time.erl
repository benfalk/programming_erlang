% Look up the definitions of erlang:now/0, erlang:date/0, and erlang:time/0.
% Write a function called my_time_func(F), which evaluates the fun F and times
% and times how long it takes.  Write a function called my_date_string() that
% neatly formats the current date and time of day.

-module(my_time).
-export([my_time_func/1]).
-export([my_date_string/0]).

my_time_func(F) ->
  Start = now(),
  Result = F(),
  [{process_time, time_diff(Start, now())}, {result, Result}].

my_date_string() ->
  {Year,Month,Day} = date(),
  lists:flatten([month_from_number(Month), " ", integer_to_string(Day), ", ", integer_to_string(Year)]).

time_diff({StartMega, StartSec, StartMicro}, {EndMega, EndSec, EndMicro}) when EndMicro > StartMicro ->
  {EndMega - StartMega, EndSec - StartSec, EndMicro - StartMicro};

time_diff({StartMega, StartSec, StartMicro}, {EndMega, EndSec, EndMicro}) ->
  {EndMega - StartMega, EndSec - StartSec - 1, EndMicro + 1000000 - StartMicro}.

month_from_number(N) ->
  element(N,{"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}).

integer_to_string(I) -> 
  io_lib:format("~p",[I]).
