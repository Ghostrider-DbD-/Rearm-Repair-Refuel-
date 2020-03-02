/*
    RRR_refuel
*/

RRR_getNearbyFuelSources = {  //  Run this every 2 sec
	params["_vehicle"];
	private _refuelDistance = RRR_fuelSourceSearchDistanceLand;
	if (typeOf _vehicle isKindOf "Air") then {_refuelDistance = RRR_fuelSourceSearchDistanceAir};
	if (typeOf _vehicle isKindOf "Ship") then {_refuelDistance = RRR_fuelSourceSearchDistanceShip};
	_refuelDistance
};

RRR_isRefuelableVehicle = {
	params["_vehicle",["_mode","external"]];
	private _vehicleType = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleclass");
	private _allowedCategories = [];
	switch (_mode) do 
	{
		case "external": {_allowedCategories = RRR_canRefuelFromExterior};
		case "driver": {_allowedCategories = RRR_canRefuelFromDriverSeat};
	};
	private _legalVehicle = if (_vehicleType in _allowedCategories) then {true} else {false};
	_legalVehicle
};

RRR_litersToAdd = {
	params["_vehicle"];
	private _fuelCapacity = getNumber(configfile >> "CfgVehicles" >> typeOf _vehicle >> "fuelCapacity");
	private _litersToAdd = _fuelCapacity * (1 - (fuel _vehicle));
	_litersToAdd	
};

RRR_getRefuelPrice = {
	params["_vehicle"];
	private _litersToAdd = [_vehicle] call RRR_litersToAdd;
	private _refuelPrice = 0;  
	if (_literstoAdd isEqualTo 0) exitWith 
	{
		_refuelPrice
	};
	if !(RRR_fuelPricePerLiter isEqualTo 0) then 
	{
		_refuelPrice = ceil(_litersToAdd * RRR_fuelPricePerLiter);
	} else {
		if (_vehicle isKindOf "car") then {_refuelPrice = RRR_refuelPriceCars};
		if (_vehicle isKindOf "tank") then {_refuelPrice = RRR_refuelPriceTanks};
		if (_vehicle isKindOf "air") then {_refuelPrice = RRR_refuelPriceAir};
		if (_vehicle isKindOf "ship") then {_refuelPrice = RRR_refuelPriceShip};
	};
	_refuelPrice
};

RRR_doVehicleRefuel = {
	params[["_vehicle",objNull],["_mode","external"]];
	if (isNull _vehicle) exitWith {hint "No Vehicle Selected"};
	//[format["doVehicleRefuel: _this = %1",_this]] call logStuff;
	//_vehicle setFuel 0.1;
	private _litersToAdd = [_vehicle] call RRR_litersToAdd;
	private _abort = false;	

	if (_mode isEqualTo "external") then 
	{
		if !(local _vehicle) then 
		{
			["ErrorTitleAndText", ["ABORTED", format["You must get into the driver's seat before refueling"]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
	};
	if (_mode isEqualTo "driver") then 
	{
		if !(local _vehicle || !(driver _vehicle isEqualTo player)) exitWith 
		{
			["ErrorTitleAndText", ["ABORTED", format["You must in the driver's seat for refueling"]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
	};

	if (_abort) exitWith {};

	private _fuelSources = [_vehicle] call RRR_getNearbyFuelSources;
	if (_fuelSources isEqualTo []) exitWith 
	{
		["ErrorTitleAndText", ["ABORTED", format["You are not near any fuel sources"]]] call ExileClient_gui_toaster_addTemplateToast;
	};
	private _startingFuel = fuel _vehicle;
	if (_startingFuel >= 1) exitWith 
	{
		["ErrorTitleAndText", ["ABORTED", format["Fuel tank is already filled"]]] call ExileClient_gui_toaster_addTemplateToast;
	};
	private _refuelPrice = [_vehicle] call RRR_getRefuelPrice;

	private _wallet = player getVariable ["ExileMoney", 0];
	private _fuelToLoad = 1 - _startingFuel;
	private _fillTankTo = 1;
	private _abort = false;
	if !(_refuelPrice isEqualTo 0) then 
	{
		if (_wallet isEqualTo 0) exitWith 
		{
			["ErrorTitleAndText", ["ABORTED", format["%1 tabs required for a full tank",(_refuelPrice)]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
 
		if (_refuelPrice > _wallet && !(_abort)) then // Only load the amount of fuel the player can pay for.
		{
			_fuelToLoad = (_wallet / _refuelPrice) * _fuelToLoad;
			_refuelPrice = _wallet;
			_fillTankTo = (fuel _vehicle) + _fuelToLoad;
			_m = format["Insufficient funds: Tank will be filled to %1 percent full",_fillTankTo * 100];
			//[_m] call logStuff;
			["ErrorTitleAndText", ["WARNING", _m]] call ExileClient_gui_toaster_addTemplateToast;
		};
	};
	if (_abort) exitWith {};
	private _refuelIncrement = 1/RRR_vehicleRefuelTime;
	private _timeToRefuel = (RRR_vehicleRefuelTime * _fuelToLoad);
	private _startTime = diag_tickTime;
	private _endTime = _startTime + _timeToRefuel;
	private _updateTime = _timeToRefuel * _refuelIncrement;
	[format["<t size='22' font='PuristaMedium'>Refueling %1 for %2 Pop Tabs</t>",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"),_refuelPrice], [1, 0, 0, 1]] call ExileClient_gui_toaster_addToast;
	if (canSuspend) then {uisleep 1;};
	private _m = format["Fuel at %1 Percent Filled",(fuel _vehicle) * 100];
	//[_m] call logStuff;
	["InfoTitleAndText", ["Refueling",_m]] call ExileClient_gui_toaster_addTemplateToast; 	
	while {diag_tickTime < _endTime} do 
	{
		_vehicle setFuel ((fuel _vehicle) + _refuelIncrement);
		//  Message Player 'refueling, tank at %1
		if (_filltankto - (fuel _vehicle) < 0.05) then 
		{
			_vehicle setFuel _fillTankto;
		};
		if (fuel _vehicle >= _fillTankTo) exitWith {};
		//[format["_doVehicleRefuel(140): fuel _vehicle %1 | _fillTankTo %2",fuel _vehicle,_fillTankTo]] call logStuff;
		uiSleep _updateTime;
		if (diag_tickTime - _startTime > 2) then 
		{
			_m = format["Fuel at %1 Percent Filled",(fuel _vehicle) * 100];
			//[_m] call logStuff;
			["InfoTitleAndText", ["Refueling",_m]] call ExileClient_gui_toaster_addTemplateToast; 
			_startTime = diag_tickTime;
		};
	};
	_vehicle setFuel _fillTankTo;
	//[format["fuel for vehicle set to %1",fuel _vehicle]] call logStuff;

	// Message Player that Refueling Complete and take some tabs
	if (_refuelPrice > 0) then 
	{
		//  	["respectToTabsRequest",[player,(GRG_respectEntered * -1),_tabs]] call ExileClient_system_network_send;
		["giveTakePlayerTabsRequest",[player,(-1) * _refuelPrice]] call ExileClient_system_network_send;
	};
	["<t size='22' font='PuristaMedium'>Refueling Complete!</t>", [1, 0, 0, 1]] call ExileClient_gui_toaster_addToast;
	RRR_actionInProgress = false;
};
/*
	end of function RRR_doVehicleRefuel
*/
