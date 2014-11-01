-module(my_module_a).

-type gender() :: male | female.
-type age() :: integer().
-type name() :: atom().
-opaque person() :: {gender(), age(), name()}.
-export_type([person/0]).

-export([persons_age/1]).
-export([new_person/3]).

-spec persons_age(Person) -> age()
  when Person :: person().
persons_age({_,Age,_}) -> Age.

-spec new_person(Gender, Age, Name) -> person()
  when Gender :: gender(),
       Age :: age(),
       Name :: name().

new_person(Gender, Age, Name) -> {Gender, Age, Name}.
