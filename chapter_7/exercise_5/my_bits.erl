% Write a function to reverse the bits in a binary.

-module(my_bits).
-export([reverse/1]).
-export([test/0]).

reverse(Bin) ->
  reverse_bits(Bin, <<>>).

reverse_bits(<<>>, Reversed) -> Reversed;
reverse_bits(Remainder, Reversed) ->
  <<Bit:1, Leftover/bits>> = Remainder,
  Reverse = <<Bit:1, Reversed/bits>>,
  reverse_bits(Leftover, Reverse).

test() ->
  <<1:1, 0:1>> = reverse(<<0:1, 1:1>>),
  Reversed = reverse(<<"Ben">>),
  <<"Ben">> = reverse(Reversed),
  tests_passed.
