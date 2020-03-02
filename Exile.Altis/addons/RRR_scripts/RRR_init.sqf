/*
	Load Settings 
*/

call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_settings.sqf";

/*
	disable autorefueling using a server-side script
*/

if (isServer && RRR_disableDefaultRefuel) then 
{
	[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_getSaveLoadout.sqf";		
	private _start = diag_tickTime;
	// set fuel of any fuel sources on the map to 0
	private _mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	private _searchDist = worldSize;
	//private _fuelSources = nearestObjects[_mapCenter,RRR_fuelSourceTypes,_searchDist];
	{
		_x setFuelCargo 0;
		//diag_log format["setting fuel cargo for %1 (%2) to 0",_x,getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
	} foreach nearestObjects[_mapCenter,RRR_fuelSourceTypes,_searchDist];  // _fuelSources;
	//{_x setFuelCargo 0} forEach nearestObjects;
	//diag_log format["RRR_init: time elapsed emptying fuel sources = %1",diag_tickTime - _start];
};


/*
	Initialize the client
*/
if (hasInterface) then
{
	/*
		Key Variables 
	*/

	RRR_driverRefuelActionHandle = -1;
	RRR_playerRefuelActionHandle = -1;

	RRR_driverRepairActionHandle = -1;
	RRR_playerRepairActionHandle = -1;

	RRR_driverRearmActionHandle = -1;
	RRR_playerRearmActionHandle = -1;

	RRR_servicePointHandleDriver = -1;
	RRR_servicePointHandlePlayer = -1;
	
	RRR_refuelStationNearby = false;
	RRR_repairStationNearby = false;
	RRR_rearmStationNearby = false;
	RRR_ServicePointNearby = false;

	RRR_actionInProgress = false;
	/*
		Compile Functions
	*/
	
		//[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_refuel.sqf";
		//[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_repair.sqf";	
		//[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_rearm.sqf";
		//[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_functions.sqf";


	if (RRR_debugMode) then 
	{
			// RRR_getSaveLoadout
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_getSaveLoadout.sqf";			
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_refuel.sqf";
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_repair.sqf";	
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_rearm.sqf";
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_pylons.sqf";
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_turrets.sqf";		
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_functions.sqf";
		[] call compile preprocessFileLineNumbers "addons\RRR_scripts\RRR_displays.sqf";		
	} else {
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_getSaveLoadout.sqf";		
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_refuel.sqf";
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_repair.sqf";	
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_rearm.sqf";	
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_pylons.sqf";		
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_turrets.sqf";				
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_functions.sqf";
		[] call compileFinal preprocessFileLineNumbers "addons\RRR_scripts\RRR_displays.sqf";		
	};
	

	if (RRR_debugMode) then 
	{
		_m = "Spawning RRR_mainLoop";
		[_m] call logStuff;		
		[] spawn RRR_mainLoop;
	} else {
		[2, RRR_monitoring, [], true] call ExileClient_system_thread_addtask;
	};
	[format["RRR_init Completed at %1",diag_tickTime]] call logStuff;
};

RRR_initialized = true;