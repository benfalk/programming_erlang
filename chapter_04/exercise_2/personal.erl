% The BIF tuple_to_list(T) converts the elements of the tuple T to a list.
% Write a function called my_tuple_to_list(T) that does the same thing
% only not using the BIF that does this.

-module(personal).
-export([my_tuple_to_list/1]).

my_tuple_to_list({})
  -> [];

my_tuple_to_list(T)
  -> extract_items_from_tuple(T, 1, tuple_size(T)).

extract_items_from_tuple(T, Size, Size)
  -> [element(Size,T)];

extract_items_from_tuple(T, Position, Size)
  -> [element(Position,T) | extract_items_from_tuple(T, Position+1, Size)].
