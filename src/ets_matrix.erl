-module(ets_matrix).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([Module, Function, MatrixWidth, MatrixHeight, RunsNo]) ->
    {Result, ok} = 
	try  
	    expected_time_estimation:run(
	      list_to_atom(Module), 
	      list_to_atom(Function), 
	      list_to_integer(MatrixWidth),
	      list_to_integer(MatrixHeight), 
	      list_to_integer(RunsNo))
	catch
	    Mod:Error ->
		io:format("~p~n",[[Mod,Error]]),
		usage()
	end,
    io:format("~p~n",[Result]);
main(_) ->
    usage().
%%====================================================================
%% Internal functions
%%====================================================================
usage()->
    io:format("usage: ets_matrix Module, Function, MatrixWidth, MatrixHeight, Number of runs \n"
	      "Module   ex.  matrix_as_map\n"
	      "Function ex.  get_value\n"
	      "MatrixWidth, MatrixHeight, the number of runs are integers\n"
              "examples: ets_matrix matrix_as_map get_value 1000 1000 1000 \n",[]).
