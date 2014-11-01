% Write a function that reverses the order of bytes in a binary

-module(my_byte).
-export([reverse/1]).

reverse(Bin) ->
  reverse_bytes(Bin, []).

reverse_bytes(<<>>, Reversed) -> list_to_binary(Reversed);
reverse_bytes(Bin, Reversed) ->
  {Byte, Remainder} = split_binary(Bin, 1),
  reverse_bytes(Remainder, [Byte|Reversed]).
