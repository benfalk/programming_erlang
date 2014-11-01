% 2. Write a function term_to_packet(Term) -> Packet that returns a binary
% consisting of a 4-byte length header N followed by N bytes of data produced
% by calling term_to_binary(Term).

% 3. Write the inverse function packet_to_term(Packet) -> Term that is the
% inverse of the previous function.

% 4. Write some tests in the style of `Adding Tests to Your Code`, to test that
% the previous two functions can correctly endcode terms into packets and
% recover the original terms by decoding the packets.

-module(my_packet).
-export([term_to_packet/1]).
-export([packet_to_term/1]).
-export([test/0]).

term_to_packet(Term) ->
  Bin = term_to_binary(Term),
  ByteSize = byte_size(Bin),
  <<ByteSize:32/big, Bin/binary>>.

packet_to_term(Packet) ->
  <<_:32/big, Bin/binary>> = Packet,
  binary_to_term(Bin).

test() ->
  Foo = term_to_packet(foo),
  foo = packet_to_term(Foo),
  tests_worked.
