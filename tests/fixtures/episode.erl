-module(episode).
-export([label/1]).

-spec label(map()) -> binary().
label(#{title := Title}) -> <<"Episode: ", Title/binary>>.
