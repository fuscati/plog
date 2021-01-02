:-use_module(library(clpfd)).
:-use_module(library(lists)).

main:-
    baker([10, 70, 24, 16], [[0, 3, 14, 1], [15, 0, 10, 25], [14, 10, 0, 3], [1, 25, 3, 0]], [10, 5, 20, 15]).

baker(PreferedTime, HouseTravelTime, BakeryTravelTime):-
    % Get the number of houses to visit
    length(PreferedTime, NumberOfHouses),


    % Route and DeliveryInstants must have an entry for each house
    length(Route, NumberOfHouses),
    length(DeliveryInstants, NumberOfHouses),
    length(DeliveryDelays, NumberOfHouses),

    % Domain
    domain(Route, 1, NumberOfHouses),
    domain(DeliveryInstants, 1, 100000),
    domain(DeliveryDelays, -100000, 100000),

    % Restrictions

    % Each house must be passed only once and the baker can't be in two houses at the same time
    all_distinct(Route),
    all_distinct(DeliveryInstants),

    % The first instant must be the the travel time from the bakery to the first house
    element(1, Route, FirstHouseID),
    element(FirstHouseID, BakeryTravelTime, BakeryToHouseTime),
    element(1, DeliveryInstants, BakeryToHouseTime),
    element(1, PreferedTime, FirstHousePreferedTime),
    FirstHouseDelay #= BakeryToHouseTime - FirstHousePreferedTime,
    FirstHouseDelay #> -10,
    element(1, DeliveryDelays, FirstHouseDelay),

    % Each house delivery instant must be equal to the previous house instant plus the travel time between houses
    append(HouseTravelTime, TravelTimeList),
    getRouteTime(Route, TravelTimeList, PreferedTime, DeliveryInstants, NumberOfHouses, DeliveryDelays),

    % The full time is equal ot the time spend passsing through all the houses plus the time from the last house to the bakery
    element(NumberOfHouses, Route, LastHouseID),
    element(LastHouseID, BakeryTravelTime, HouseToBakeryTime),
    element(NumberOfHouses, DeliveryInstants, LastInstant),
    Time #= LastInstant + HouseToBakeryTime + 5,

    % Get the sum of the delays
    getDelaySum(DeliveryDelays, DelaySum),
    getDelayImpact(DeliveryDelays, DelayImpact),

    M #= Time + DelayImpact,

    labeling([minimize(M)], Route),

    format('Total time: ~w\n', Time),
    format('Route: ~w\n', [Route]),
    format('DeliveryInstants: ~w\n', [DeliveryInstants]),
    format('DeliveryDelays: ~w\n', [DeliveryDelays]),
    format('DelaySum: ~w\n', DelaySum),
    format('DelayImpact: ~w\n', DelayImpact).

getRouteTime([PrevHouse, House], TravelTimeList, PreferedTime, [PrevHouseTime, HouseTime], NumberOfHouses, [_, HouseDelay]):-
    Position #= (PrevHouse - 1) * NumberOfHouses + House,
    element(Position, TravelTimeList, HouseTravelTime),
    HouseTime #= (PrevHouseTime + 5) + HouseTravelTime,

    % Get Delay
    element(House, PreferedTime, DeliveryTime),
    HouseDelay #= HouseTime - DeliveryTime,
    HouseDelay #> -10.

getRouteTime([PrevHouse, House|Rest], TravelTimeList, PreferedTime, [PrevHouseTime, HouseTime | RestTime], NumberOfHouses, [_, HouseDelay | RestDelay]):-
    % Get travel Time
    Position #= (PrevHouse - 1) * NumberOfHouses + House,
    element(Position, TravelTimeList, HouseTravelTime),
    HouseTime #= HouseTravelTime + (PrevHouseTime + 5),

    % Get Delay
    element(House, PreferedTime, DeliveryTime),
    HouseDelay #= HouseTime - DeliveryTime,
    HouseDelay #> -10,

    getRouteTime([House|Rest], TravelTimeList, PreferedTime, [HouseTime | RestTime], NumberOfHouses, [HouseDelay | RestDelay]).

getDelaySum([], 0).
getDelaySum([H|T], DelaySum) :-
  getDelaySum(T, Rest),
  DelaySum #= abs(H) + Rest.

getDelayImpact([], 0).

getDelayImpact([H|T], DelayImpact) :-
  getDelayImpact(T, Rest),
  DelayImpact #= Rest + H * H.
