% file:read_file(File) returns {ok, Bin} or {error, Why} where File is the
% filename and Bin contains the contents of he file.  Write a function
% myfile:read(File) that returns Bin if the file can be read and raises an
% exception if the file cannot be read.

-module(myfile).
-export([read/1]).

read(File) ->
  case file:read_file(File) of
    {ok, Bin}    -> Bin;
    {error, Why} -> error({error, Why})
  end.
