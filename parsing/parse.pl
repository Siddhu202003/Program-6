
%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

% Main parse predicate
parse(X) :- lines(X, []).

% Lines -> Line ; Lines | Line
lines(Input, Rest) :- 
    line(Input, [';'|Rest1]),
    lines(Rest1, Rest).

lines(Input, Rest) :- 
    line(Input, Rest).

% Line -> Num , Line | Num
line(Input, Rest) :- 
    num(Input, [','|Rest1]),
    line(Rest1, Rest).

line(Input, Rest) :- 
    num(Input, Rest).

% Num -> Digit Num | Digit
num(Input, Rest) :- 
    digit(Input, Rest1),
    num(Rest1, Rest).

num(Input, Rest) :- 
    digit(Input, Rest).

% Digit -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
digit(['0'|Rest], Rest).
digit(['1'|Rest], Rest).
digit(['2'|Rest], Rest).
digit(['3'|Rest], Rest).
digit(['4'|Rest], Rest).
digit(['5'|Rest], Rest).
digit(['6'|Rest], Rest).
digit(['7'|Rest], Rest).
digit(['8'|Rest], Rest).
digit(['9'|Rest], Rest).

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
