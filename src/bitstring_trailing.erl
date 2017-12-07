%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 3 Dec 2017 by Math
%%%-------------------------------------------------------------------
-module(bitstring_trailing).
-export([length/1,
	 compress/1,
	 coordinates_to_bits/2]).

length(0)->1;
length(Integer)->
    LeadingBinAsInt = binary:at(binary:encode_unsigned(Integer),0),
    IntegerLength = length(LeadingBinAsInt, bit_size(<<LeadingBinAsInt>>)),
    IntegerLength + ((size(binary:encode_unsigned(Integer))-1)*8).

length(_Integer, 0)->
    0;
length(Integer, Size)->
    <<TrailedInteger:Size/bitstring, _Rest/bitstring>> = <<Integer>>,
    case TrailedInteger =/= <<0:Size>> of 
     	true  -> length(Integer, Size-1);
     	false -> bit_size(<<Integer>>) - Size
     end.

compress(0)->
    <<>>;
compress(Integer)->
    IntegerBin =
	binary:encode_unsigned(Integer),
    {LeadingBinAsInt,Tail} = 
	separete_leading_bin_from_tail(IntegerBin),
    {NoOfZeroBits, NoOfBits} =
	how_many_leading_zeros_and_significant_bits(LeadingBinAsInt),
    TailBitSize =
	get_tail_bit_size(IntegerBin),  

    <<_Zeros:NoOfZeroBits/bitstring,IntegerBit:NoOfBits/bitstring>> = <<LeadingBinAsInt>>,    
    <<IntegerBit:NoOfBits/bitstring,Tail:TailBitSize/bitstring>>.


separete_leading_bin_from_tail(IntegerBin)->
    LeadingBinAsInt = binary:at(IntegerBin,0),
    Tail = binary:part(IntegerBin, {1,byte_size(IntegerBin)-1}),
    {LeadingBinAsInt,Tail}.

get_tail_bit_size(IntegerBin)->
    bit_size(IntegerBin) - bit_size(<<1>>).

how_many_leading_zeros_and_significant_bits(LeadingBinAsInt)->
    NoOfBits = ?MODULE:length(LeadingBinAsInt),
    NoOfZeroBits = bit_size(<<1>>)-NoOfBits,
    {NoOfZeroBits, NoOfBits}.

coordinates_to_bits({X,Y},MaxYLength) ->
    X_bit = compress(X),
    Y_bit = compress(Y),
    UnequivocalizerLength = MaxYLength - bit_size(Y_bit),%see comment below
    <<X_bit/bitstring,
      <<0>>:UnequivocalizerLength/bitstring,
      Y_bit/bitstring>>.

%% We need add the zeros to get unequivocal index
%% If we don't we can for example get the same index with:
%% X = 00001010 Y = 00001010 -> 1010++1010
%% X = 00101010 Y = 00000010 -> 101010++10
%% But if we we add, the X and the Y have separate memory spaces,
%% so if one of  them is different index is different
%% MaxYLength = 4
%% X = 00001010 Y = 00001010 -> 1010++1010
%% X = 00101010 Y = 00000010 -> 101010++0010
%% The solution is unequivocal because the number leading zeros in X can be deducted 
%% from the results lenght
