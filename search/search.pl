%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%

% State representation: state(Room, KeysCollected, Path)
% - Room: current room location
% - KeysCollected: list of keys collected so far
% - Path: list of moves taken to reach this state

% Main search predicate - initiates BFS from starting room
search(Actions) :- 
    initial(Start),
    bfs([[state(Start, [], [])]], Actions).

% BFS search - goal reached when treasure is found
bfs([[state(Room, _, Path) | _] | _], Actions) :- 
    treasure(Room),
    reverse(Path, Actions).

% BFS search - explore neighboring states
bfs([Current | Rest], Actions) :- 
    Current = [state(Room, Keys, Path) | Visited],
    findall(
        [state(NewRoom, NewKeys, NewPath) | Current],
        (
            next_state(Room, Keys, NewRoom, NewKeys),
            (NewRoom = Room -> NewPath = Path ; NewPath = [move(Room, NewRoom) | Path]),
            \+ member(state(NewRoom, NewKeys, _), Visited)
        ),
        NewStates
    ),
    append(Rest, NewStates, Queue),
    bfs(Queue, Actions).

% Movement through unlocked door (bidirectional)
next_state(Room1, Keys, Room2, Keys) :- 
    door(Room1, Room2).

next_state(Room1, Keys, Room2, Keys) :- 
    door(Room2, Room1).

% Movement through locked door with required key (bidirectional)
next_state(Room1, Keys, Room2, Keys) :- 
    locked_door(Room1, Room2, Lock),
    member(Lock, Keys).

next_state(Room1, Keys, Room2, Keys) :- 
    locked_door(Room2, Room1, Lock),
    member(Lock, Keys).

% Key collection - stay in same room, add key to collection
next_state(Room, Keys, Room, NewKeys) :- 
    key(Room, KeyColor),
    \+ member(KeyColor, Keys),
    NewKeys = [KeyColor | Keys].
