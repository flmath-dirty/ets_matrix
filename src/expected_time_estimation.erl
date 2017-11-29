%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(expected_time_estimation).

-export([prepare_arguments/4,
	 prepare_matrix/3,
	 run/5]).

prepare_matrix(Module, MatrixWidth, MatrixHeight)->
    {Matrix, _, _} = generate_matrix:arithmetic_sum(MatrixWidth, MatrixHeight),
    Module:load(Matrix).

prepare_arguments(_Matrix, 0, _Height, get_value)->
    erlang:error(degenerate_matrix);
prepare_arguments(Matrix, Width, Height, get_value)->
    MiddleWidth = trunc(Width/2),
    MiddleHeight = trunc(Height/2),
    [MiddleWidth, MiddleHeight, Matrix]. 
    
run(Module, Function, MatrixWidth, MatrixHeight, RunsNo)->
    Matrix = prepare_matrix(Module, MatrixWidth, MatrixHeight),
    Arguments = prepare_arguments(Matrix,  MatrixWidth, MatrixHeight, Function),
    timer:tc(repeat_apply, on_matrix, [Module,Function,Arguments,RunsNo]).

