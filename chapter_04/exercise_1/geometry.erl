-module(geometry).
-export([area/1]).
-export([perimeter/1]).

area({rectangle, Width, Height})
  -> Width * Height;

area({circle, Radius})
  -> math:pi() * Radius * Radius;

area({right_triangle, Rise, Run})
  -> Rise * Run / 2.0;

area({square, Side})
  -> Side * Side.

perimeter({rectangle, Width, Height})
  -> Width + Width + Height + Height;

perimeter({circle, Radius})
  -> math:pi() * ( Radius + Radius );

perimeter({right_triangle, Rise, Run})
  -> Rise + Run + hypotenuse(Rise, Run).

hypotenuse(Rise, Run)
  -> math:sqrt((Rise*Rise)+(Run*Run)).
