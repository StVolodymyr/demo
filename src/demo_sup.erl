
-module(demo_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([start_worker/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================
start_worker(Id) ->
    supervisor:start_child(demo_workers_sup, [Id]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
init([demo_workers]) ->
    Children =
    [
		{   undefined,
			{demo_worker,start_link,[]},
			temporary,
			2000,
			worker,
			[]
		}
    ],
    {ok, {{simple_one_for_one, 1000, 1000}, Children}};

init([]) ->
	Children =
	[
	    {   demo_workers_sup,
	        {supervisor,start_link, [{local, demo_workers_sup}, ?MODULE, [demo_workers]]},
	        permanent,
            infinity,
            supervisor,
            []
	    }
	],
    {ok, { {one_for_one, 5, 10}, Children} }.

