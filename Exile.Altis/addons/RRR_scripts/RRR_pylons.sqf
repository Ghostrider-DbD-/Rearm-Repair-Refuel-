RRR_allPylonNames = {
	params["_vehicle"];
	//[format["allPylonNames: _vehicle = %1",_vehicle]] call logStuff;
	private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	_pylonnames
};

RRR_getPylonLoadouts = {
	private _vehicle = cursorTarget;
	private _loadout = getPylonMagazines _vehicle;
	_loadout
};

RRR_clearPylonLoadouts = {
	params["_vehicle"];
	private _pylons = [_vehicle] call RRR_allPylonNames;
	{
		_vehicle setPylonLoadout [_forEachIndex + 1,""];
		_vehicle setAmmoOnPylon [_forEachIndex + 1, 0];
	} forEach _pylons;
};

RRR_defaultMagazinePylon = {
	params["_classname","_pylonname"];
	private _magazinename = getText (configFile >> "CfgVehicles" >> _classname >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylonname >> "attachment");
	_magazinename
};

RRR_setPylonLoadouts = {
	params["_vehicle","_pylonLoadout"];
	private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};	
	{
		 _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]; 
		 //[format["restored pylon loadout:  vehicle %1 | magazine %2",_vehicle,_x]] call logStuff;
	} forEach _pylonLoadout;
	//hint format["pylon loadout restored: %1",getPylonMagazines _vehicle];
};






