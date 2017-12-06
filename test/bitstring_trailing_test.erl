%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(bitstring_trailing_test).

-include_lib("eunit/include/eunit.hrl").

zero_length_test()->
    AssumedResult = 1,
    ActualResult =  bitstring_trailing:length(0),
    ?assertEqual(AssumedResult, ActualResult).

one_length_test()->
    AssumedResult = 1,
    ActualResult =  bitstring_trailing:length(1),
    ?assertEqual(AssumedResult, ActualResult).

two_length_test()->
    AssumedResult = 2,
    ActualResult =  bitstring_trailing:length(2),
    ?assertEqual(AssumedResult, ActualResult).

three_length_test()->
    AssumedResult = 2,
    ActualResult =  bitstring_trailing:length(3),
    ?assertEqual(AssumedResult, ActualResult).

four_length_test()->
    AssumedResult = 3,
    ActualResult =  bitstring_trailing:length(4),
    ?assertEqual(AssumedResult, ActualResult).

thousand_length_test()->
    AssumedResult = 10,%1111101000
    ActualResult =  bitstring_trailing:length(1000),
    ?assertEqual(AssumedResult, ActualResult).

thousand_one_length_test()->
    AssumedResult = 10,%1111101001
    ActualResult =  bitstring_trailing:length(1001),
    ?assertEqual(AssumedResult, ActualResult).

thousand_25_length_test()->
    AssumedResult = 11,%10000000000
    ActualResult =  bitstring_trailing:length(1025),
    ?assertEqual(AssumedResult, ActualResult).

eight_thousand_length_test()->
    AssumedResult = 14,%10000000000000
    ActualResult =  bitstring_trailing:length(8193),
    ?assertEqual(AssumedResult, ActualResult).


zero_compress_test()->
    AssumedResult = <<>>,
    ActualResult =  bitstring_trailing:compress(0),
    ?assertEqual(AssumedResult, ActualResult).

one_compress_test()->
    AssumedResult = <<1:1>>,
    ActualResult =  bitstring_trailing:compress(1),
    ?assertEqual(AssumedResult, ActualResult).

two_compress_test()->
     AssumedResult = <<2:2>>,
     ActualResult =  bitstring_trailing:compress(2),
     ?assertEqual(AssumedResult, ActualResult).

three_compress_test()->
    AssumedResult = <<3:2>>,
    ActualResult =  bitstring_trailing:compress(3),
    ?assertEqual(AssumedResult, ActualResult).

four_compress_test()->
    AssumedResult = <<4:3>>,
    ActualResult =  bitstring_trailing:compress(4),
    ?assertEqual(AssumedResult, ActualResult).

thousand_compress_test()->
    AssumedResult = << 1000:10 >>,%1111101000
    ActualResult =  bitstring_trailing:compress(1000),
    ?assertEqual(AssumedResult, ActualResult).

thousand_one_compress_test()->
     AssumedResult = <<1001:10>>,%1111101001
     ActualResult =  bitstring_trailing:compress(1001),
     ?assertEqual(AssumedResult, ActualResult).

thousand_25_compress_test()->
    AssumedResult = << 1025:11 >>,%10000000000
    ActualResult =  bitstring_trailing:compress(1025),
    ?assertEqual(AssumedResult, ActualResult).

eight_thousand_compress_test()->
     AssumedResult = <<8193:14>>,%10000000000000
     ActualResult =  bitstring_trailing:compress(8193),
    ?assertEqual(AssumedResult, ActualResult).

