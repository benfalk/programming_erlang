-module(my_module_b).

-type route_instruction() :: {my_module_a:navigation_direction(), integer()}.
-type route_plan() :: [route_instruction(),...].
-export_type([route_instruction/0, route_plan/0]).

-export([reverse_route/1]).

-spec reverse_route(route_plan()) -> route_plan().
reverse_route(RoutePlan) ->
  [{my_module_a:reverse_direction(Direction),Distance} || {Direction,Distance} <- lists:reverse(RoutePlan)].
