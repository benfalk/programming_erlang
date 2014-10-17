-module(my_module_a).

-type navigation_direction() :: north | south | east | west.
-export_type([navigation_direction/0]).

-export([reverse_direction/1]).

-spec reverse_direction(navigation_direction()) -> navigation_direction().
reverse_direction(north) -> south;
reverse_direction(south) -> north;
reverse_direction(east) -> west;
reverse_direction(west) -> east.
