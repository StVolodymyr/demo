-module(demo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    demo_sup:start_link(),
    demo_sup:start_worker(1),
    demo_sup:start_worker(2).
    
stop(_State) ->
    ok.
