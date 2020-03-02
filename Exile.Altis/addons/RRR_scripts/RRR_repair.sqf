/*
	RRR_repair
*/

RRR_getNearbyRepairStations = {
	params["_vehicle"];
	private _repairDistance = RRR_repairStationSearchDistanceLand;
	if (typeOf _vehicle isKindOf "Air") then {_repairDistance = RRR_repairStationSearchDistanceAir};
	if (typeOf _vehicle isKindOf "Ship") then {_repairDistance = RRR_repairStationSearchDistanceShip};
	RRR_repairSources = nearestObjects [_vehicle,RRR_repairStationTypes,_repairDistance];
	RRR_repairSources	
};

RRR_isRepairableVehicle = {
	params["_vehicle",["_mode","external"]];
	private _vehicleType = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleclass");
	//[format["_vehicle %1 | _vehicleType %2",_vehicle,_vehicleType]] call logStuff;
	private _allowedCategories = [];
	switch (_mode) do 
	{
		case "external": {_allowedCategories = RRR_canRepairFromExterior};
		case "driver": {_allowedCategories = RRR_canRepairFromDriverSeat};
	};
	private _legalVehicle  = if (_vehicleType in _allowedCategories) then {true} else {false};
	diag_log format["isRepairableVehicle vehicle returning %1 for vehicle %2 vehicleClass %3 | _mode = %4 | _allowedCategories %5",_legalVehicle,_vehicle,_vehicleType,_mode,_allowedCategories];
	_legalVehicle
};

RRR_doVehicleRepair = {

	//RRR_actionInProgress = true;	
	params[["_vehicle",objNull],"_mode"];
	if (isNull _vehicle) exitWith {hint "No vehicle selected"};
	if ((damage _vehicle) isEqualTo 0) then 
	{
		["ErrorTitleAndText", ["ABORTED", format["No Repairs Required"]]] call ExileClient_gui_toaster_addTemplateToast;
	};
	private _abort = false;
	
	if (_mode isEqualTo "external") then 
	{
		if !(local _vehicle) then 
		{
			["ErrorTitleAndText", ["ABORTED", format["You must get into the driver's seat before repairing"]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
	};
	if (_mode isEqualTo "driver") then 
	{
		if !(local _vehicle || !(driver _vehicle isEqualTo player)) exitWith 
		{
			["ErrorTitleAndText", ["ABORTED", format["You must in the driver's seat for repairing"]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
	};

	if (_abort) exitWith {};
	private _canRepairVehicle = [_vehicle,"driver"] call RRR_isRepairableVehicle;
	private _repairStations = [_vehicle] call RRR_getNearbyRepairStations;	
	if (_repairStations isEqualTo []) exitWith 
	{
		["ErrorTitleAndText", ["ABORTED", format["You are not near any repair stations"]]] call ExileClient_gui_toaster_addTemplateToast;
	};	
	private _repairPrice = [_vehicle] call RRR_getRepairPrice;
	if (_repairPrice isEqualTo -1) exitWith 
	{
		["ErrorTitleAndText", ["ABORTED", format["This Vehicle Can Not Be Repaired Here"]]] call ExileClient_gui_toaster_addTemplateToast;
	}; // Invalid vehicle

	private _wallet = player getVariable ["ExileMoney", 0];
	private _abort = false;
	if !(_repairPrice isEqualTo 0) then 
	{
		if (_repairPrice > _wallet) then // Only load the amount of fuel the player can pay for.
		{
			["ErrorTitleAndText", ["WARNING", format["Insufficient funds for repair"]]] call ExileClient_gui_toaster_addTemplateToast;
			_abort = true;
		};
	};	
	if (_abort) exitWith {};

	private _allHitPoints = (getAllHitPointsDamage _vehicle) select 0; // https://community.bistudio.com/wiki/getAllHitPointsDamage
	//private _interval = RRR_vehicleRepairTime / (count _allHitPoints);
	private _interval = RRR_vehicleRepairTimePerHitpoint;  //  this way the more complex the vehicle the longer it takes
	private _startingPos = getPosATL _vehicle;
	private _abort = false;
	_vehicle engineOn false;
	private _done = false;
	[format["<t size='22' font='PuristaMedium'>Repairing %1</t>",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")], [1, 0, 0, 1]] call ExileClient_gui_toaster_addToast;	
	{
		if (((getPosATL _vehicle) distance _startingPos > 3) || isEngineOn _vehicle) exitWith // put a little slack in the monitoring of location to account for movement of ships
		{
			["InfoTitleAndText", ["Repair Aborted","Engine must remain off with vehicle stationairy for repairs to occur"]] call ExileClient_gui_toaster_addTemplateToast; 
			["InfoTitleAndText", ["Repair Costs Deducted","For Any Repairs Done"]] call ExileClient_gui_toaster_addTemplateToast; 
			_abort = true;
		};
		private _hitPoint = _x;
		if ((_vehicle getHitPointDamage _hitPoint) > 0) then 
		{
			_vehicle setHitPointDamage [_hitPoint,0];
			_hpName = _hitPoint splitString "";
			_hpName deleteRange[0,3];
			_hpName = _hpName joinString "";
			_m = format["<t size='22' font='PuristaMedium'>Repairing %1</t>",_hpName];
			//[_m] call logStuff;
			["InfoTitleAndText", ["Repairing",_m]] call ExileClient_gui_toaster_addTemplateToast; 
			if (canSuspend) then {uiSleep _interval;};
		};
	}forEach _allHitPoints; // the list of hit point names
	_done = true;
	// Message Player that Refueling Complete and take some tabs
	if (_repairPrice > 0) then 
	{
		//  	["respectToTabsRequest",[player,(GRG_respectEntered * -1),_tabs]] call ExileClient_system_network_send;
		private _tabsDeducted = (-1) * _repairPrice;
		["giveTakePlayerTabsRequest",[player,_tabsDeducted]] call ExileClient_system_network_send;
		//[format["RRR_doVehicleRepair: _tabsDeducted = %1",_tabsDeducted]] call logStuff;
	};
	if !(_abort) then 
	{
		["<t size='22' font='PuristaMedium'>Vehicle Repaired!</t>", [1, 0, 0, 1]] call ExileClient_gui_toaster_addToast;
		_vehicle setDamage 0;
	};
	if (RRR_debugMode) then 
	{
		//[format["Vehicle %1 | Damage %2",_vehicle, damage _vehicle]] call logStuff;
		private _allHitPoints = (getAllHitPointsDamage _vehicle) select 0; 
		{
			_m = format["vehicle %1 | hitpoint %2 = %3",_vehicle,_x,_vehicle getHitPointDamage _x];
			[_m] call logStuff;
		} forEach _allHitPoints;
	};
	RRR_actionInProgress = false;	
};
/*
	end RRR_doVehicleRepair
*/

RRR_getRepairPrice = {
	params["_vehicle"];
	private _price = 0;
	private _vType = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass");
	if (_vType in ["Car"]) then {_price = RRR_repairPriceCars};
	if (_vType in ["Air"]) then {_price = RRR_repairPriceAir};
	if (_vType in ["Armored"]) then {_price = RRR_repairPriceTanks};
	if (_vType in ["Ship"]) then {_price = RRR_repairPriceShip};
	_price
};

