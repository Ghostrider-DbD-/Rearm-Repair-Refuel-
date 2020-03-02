/*

*/

RRR_isRearmableVehicle = {
	params["_vehicle",["_mode","external"]];
	private _vehicleType = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleclass");
	private _allowedCategories = [];
	switch (_mode) do 
	{
		case "external": {_allowedCategories = RRR_canRepairFromExterior};
		case "driver": {_allowedCategories = RRR_canRepairFromDriverSeat};
	};
	private _legalVehicle = if (_vehicleType in _allowedCategories) then {true} else {false};
	_legalVehicle
};

RRR_getNearbyRearmStations = {
	params["_vehicle"];
	private _rearmStations = RRR_rearmStationSearchDistanceLand;
	if (typeOf _vehicle isKindOf "Air") then {_rearmDistance = RRR_rearmStationSearchDistanceAir};
	if (typeOf _vehicle isKindOf "Ship") then {_rearmDistance = RRR_rearmStationSearchDistanceShip};
	_rearmStations	
};



