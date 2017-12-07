%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 7 Dec 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_bit_map).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    LengthOfY = bitstring_trailing:length(Height),
    PropList = 
	[{
	   bitstring_trailing:coordinates_to_bits({X,Y},LengthOfY),
	   element(X+(Y-1)*Width, Matrix)
	 } || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    
    maps:from_list(lists:append(
		     [{height, Height}, {width, Width}, {lengthOfY, LengthOfY}], PropList)).

rows_sums({0,0,_})-> [];
rows_sums(Map)->
    #{height:=Height, width:=Width, lengthOfY:=LengthOfY}=Map,
    rows_sums(Map, 1, Height, Width, LengthOfY).

rows_sums(_, HeightStop, Height, _, _) when HeightStop==Height+1->
    [];
rows_sums(Map, RowIndex, Height, Width, LengthOfY)->
    RowIndexes = 
	[bitstring_trailing:coordinates_to_bits({X, RowIndex}, LengthOfY) || X<-lists:seq(1,Width)],
    RowSubmap = maps:with(RowIndexes, Map),
    TheSum = lists:sum(maps:values(RowSubmap)),
    [TheSum | rows_sums(Map, RowIndex+1, Height, Width, LengthOfY)].

cols_sums({0,0,_})-> [];
cols_sums(Map)->
    #{height:=Height, width:=Width, lengthOfY:=LengthOfY}=Map,
    cols_sums(Map, 1, Width, Height, LengthOfY).

cols_sums(_, WidthStop, Width, _, _) when WidthStop==Width+1->
    [];
cols_sums(Map, ColIndex, Width, Height, LengthOfY)->
    ColIndexes = 
	[bitstring_trailing:coordinates_to_bits({ColIndex,Y}, LengthOfY) || Y<-lists:seq(1,Height)],
    Colsubmap = maps:with(ColIndexes, Map),
    TheSum = lists:sum(maps:values(Colsubmap)),
    [TheSum | cols_sums(Map, ColIndex+1, Width, Height, LengthOfY)].

get_value(TheX, TheY, Map)->
    #{lengthOfY:=LengthOfY} = Map,
    Index = bitstring_trailing:coordinates_to_bits({TheX,TheY}, LengthOfY),
    maps:get(Index, Map).

set_value(TheX, TheY, NewValue, Map)->
    #{lengthOfY:=LengthOfY} = Map,
    Index = bitstring_trailing:coordinates_to_bits({TheX,TheY}, LengthOfY),
    Map#{Index:=NewValue}.
