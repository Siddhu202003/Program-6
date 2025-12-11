%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%

% State representation: state(Room, KeysCollected, Path)
% where Room is current room, KeysCollected is list of keys collected, Path is list of moves

search(Actions) :- 
    initial(Start),
    bfs([[state(Start, [], [])]], Actions).

% BFS search - found treasure
bfs([[state(Room, _, Path)|_]|_], Actions) :- 
    treasure(Room),
    reverse(Path, Actions).

% BFS search - explore next states
bfs([Current|Rest], Actions) :- 
    Current = [state(Room, Keys, Path)|Visited],
    findall(
        [state(NewRoom, NewKeys, NewPath)|Current],
        (
            next_state(Room, Keys, NewRoom, NewKeys),
            (NewRoom = Room -> NewPath = Path ; NewPath = [move(Room, NewRoom)|Path]),
            \+ member(state(NewRoom, NewKeys, _), Visited)
        ),
        NewStates
    ),
    append(Rest, NewStates, Queue),
    bfs(Queue, Actions).

% Can move through an unlocked door
next_state(Room1, Keys, Room2, Keys) :- 
    door(Room1, Room2).

next_state(Room1, Keys, Room2, Keys) :- 
    door(Room2, Room1).

% Can move through a locked door if we have the key
next_state(Room1, Keys, Room2, Keys) :- 
    locked_door(Room1, Room2, Lock),
    member(Lock, Keys).

next_state(Room1, Keys, Room2, Keys) :- 
    locked_door(Room2, Room1, Lock),
    member(Lock, Keys).

% Pick up a key if in the same room
next_state(Room, Keys, Room, NewKeys) :- 
    key(Room, KeyColor),
    \+ member(KeyColor, Keys),
    NewKeys = [KeyColor|Keys].
