if (isNil "logStuff") then 
{
	logStuff = {
		params["_m"];
		systemChat _m;
		diag_log _m;
};
};

RRR_getAllowedPylonAmmo = {
	params["_vehicle"];

	private _pylonAmmoAllowedRaw = _vehicle getCompatiblePylonMagazines 0;  // all pylon ammmo on vehicle
	private _pylonammoallowed = [];
	{
		//[format["pylonAmmoAllowedRaw dump: data = %1",_x]] call logStuff;
		{
			_pylonammoallowed pushBackUnique _x;
		} forEach _x;
	} forEach _pylonAmmoAllowedRaw;
	
	//{
		//[format["pylonAmmoAllowed dump: data = %1",_x]] call logStuff;
	//} forEach _pylonAmmoAllowed;
	
	_pylonAmmoAllowed
};

RRR_getVehicleLoadouts = {
	private _vehicle = _this select 0;
	//diag_log format["_getVehicleLoadouts: _this = %1",_this];
	private _magazinesAmmoLoadout = magazinesAmmoFull _vehicle;
	
	/*
	{
		_x params["_magazine","_turret","_rounds"];
		_l = format["magazine %1 | path %2 | rounds %3",_magazine,_turret,_rounds];
		//[format["magazinesAmmoFull Dump:  vehicle %1 | line %2 | loadout %3",_vehicle,_forEachIndex,_l]] call logStuff;	
		//[format["magazinesAmmoFull Dump:  data = %1",_x]] call logStuff;			
	} forEach _magazinesAmmoLoadout;
	*/
	
	private _pylonammoallowed = [_vehicle] call RRR_getAllowedPylonAmmo;
	private _turretLoadout = [];
	private _mags = magazinesAllTurrets _vehicle;
	{ 
		_x params["_magazine","_turret","_rounds"];
		if !(_magazine in _pylonAmmoAllowed) then {_turretLoadout pushBack _x};
		//_l = format["magazine %1 | path %2 | rounds %3",_magazine,_turret,_rounds];
		//[format["magazinesAllTurrets Dump: vehicle %1 | line %2 | loadout %3",_vehicle,_forEachIndex,_l]] call logStuff;	
		//[format["magazinesAllTurrets Dump: data = %1",_x]] call logStuff;			
	} forEach _mags;
	/*
	private _turrets = allTurrets _vehicle;
	{
		//[format["turretLoadout dump: data = %1",_x]] call logStuff;
	} forEach _turretLoadout;
	*/
	private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	private _pylonLoadouts = [];
	private _pylonMagazines = getPylonMagazines _vehicle;
	{
		private _pylonWeapon = _pylonMagazines select _forEachIndex;
		private _pylonAmmoCount = _vehicle ammoOnPylon _x;
		_pylonLoadouts pushback [_x,_pylonWeapon,_pylonAmmoCount];
	} forEach _pylonNames;

	/*
	{
		//[format["pylonLoadouts dump: data = %1",_x]] call logStuff;
	} forEach _pylonLoadouts;
	*/

	_loadout = [_turretLoadout,_pylonLoadouts];
	_loadout
};

RRR_storeVehicleLoadout = {
	private _parameters = _this;
	private _vehicle = cursorTarget;
	RRR_vehicleLoadout = [_vehicle] call RRR_getVehicleLoadouts;

};

RRR_setVehicleLoadout = {
	private _vehicle = _this select 0;
	private _loadout = _this select 1;
	_loadout params["_turretLoadout","_pylonLoadout"];
	//diag_log format["_setVehicleLoadout: _this = 1",_this];
	//diag_log format["_setVehicleLoadout: _vehicle name = %1 | _vehicle = %2",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"),_vehicle];
	//diag_log format["_setVehicleLoadout: _loadout = %1",_loadout];
	//diag_log format["_setVehicleLoadout: _turretLoadout = %1",_turretLoadout];
	//diag_log format["_setVehicleLoadout: _pylonLoadout = %1",_pylonLoadout];
	//diag_log format["RRR_setVehicleLoadout: _vehicle = %1 | vehicle Name %4 | _turretLoadout = %2 | _pylonLoadout = %3",_vehicle,_turretLoadout,_pylonLoadout,getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")];
	// clear any loaded ammo
	//private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	[_vehicle] call RRR_clearVehicleLoadout;

	// deal with turrets;
	{
		_x params["_magazine","_turretPath","_ammoCount"];
		_vehicle addMagazineTurret[_magazine,_turretPath,_ammoCount];
		//[format["turret %1 ammo set to %2",_turretPath,_vehicle magazinesTurret _turretPath]] call logStuff;		
	} forEach _turretLoadout;

	private _pylonMagazines = getPylonMagazines _vehicle;
	// deal with pylons 
	{
		_x params["_pylonName","_pylonWeapon","_ammoCount"];
		//[format["current pylon loadout: pylon %1 | weapon %2 | rounds/missles %3",_pylonName,_pylonMagazines select _forEachIndex,_vehicle ammoOnPylon _pylonName]] call logStuff;
		//[format["weapons to load: pylon %1 | weapon %2 | rounds/missiles %3",_pylonName, _pylonName,_ammoCount]] call logStuff;

		_vehicle setPylonLoadOut [_pylonName,_pylonWeapon];
		_vehicle setAmmoOnPylon [_pylonName,_ammoCount];
		//[format["pylon loadout updated to: pylon %1 | weapon %2 | rounds/missles %3",_pylonName,_pylonMagazines select _forEachIndex,_vehicle ammoOnPylon _pylonName]] call logStuff;		
	} forEach _pylonLoadout;
};

RRR_applyVehicleLoadout = {
	[cursorTarget,RRR_vehicleLoadout] call RRR_setVehicleLoadout;
};

RRR_clearVehicleLoadout = {
	private _vehicle = _this select 0;
// clear any loaded ammo
	private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	{
		_vehicle setPylonLoadOut [_x,""];
	} forEach _pylonNames;

	{
		_x params["_magazine","_turretPath","_ammoCount"];		
		_vehicle removeMagazinesTurret [_magazine,_turretPath];
	} forEach magazinesAllTurrets _vehicle;

	{
		_x params["_magazine","_turretPath","_ammoCount"];		
		//[format["turret %1 cleared to Ammo %2",_turretPath,_vehicle magazinesTurret _turretPath]] call logStuff;
	} forEach magazinesAllTurrets _vehicle;
	true
};

RRR_emptyLoadout = {
	[cursorTarget] call RRR_clearVehicleLoadout;
	hint "ammo removed";
};

RRR_getVehicleLoadoutsHalfAmmoCounts = {
	private _vehicle = _this select 0;
	private _magazinesAmmoLoadout = magazinesAmmoFull _vehicle;
	{
		_x params["_magazine","_turret","_rounds"];
		_l = format["magazine %1 | path %2 | rounds %3",_magazine,_turret,_rounds];
		//[format["magazinesAmmoFull Dump:  vehicle %1 | line %2 | loadout %3",_vehicle,_forEachIndex,_l]] call logStuff;	
		//[format["magazinesAmmoFull Dump:  data = %1",_x]] call logStuff;			
	} forEach _magazinesAmmoLoadout;
	
	private _pylonammoallowed = [_vehicle] call RRR_getAllowedPylonAmmo;
	private _turretLoadout = [];
	private _mags = magazinesAllTurrets _vehicle;
	{ 
		_x params["_magazine","_turret","_rounds"];
		if !(_magazine in _pylonAmmoAllowed) then {_turretLoadout pushBack [_magazine,_turret,floor(_rounds/2)]};
		_l = format["magazine %1 | path %2 | rounds %3",_magazine,_turret,_rounds];
	//	[format["magazinesAllTurrets Dump: vehicle %1 | line %2 | loadout %3",_vehicle,_forEachIndex,_l]] call logStuff;	
	//	[format["magazinesAllTurrets Dump: data = %1",_x]] call logStuff;			
	} forEach _mags;

	private _turrets = allTurrets _vehicle;
	{
		//[format["turretLoadout dump: data = %1",_x]] call logStuff;
	} forEach _turretLoadout;
	private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	private _pylonLoadouts = [];
	private _pylonMagazines = getPylonMagazines _vehicle;
	{
		private _pylonWeapon = _pylonMagazines select _forEachIndex;
		private _pylonAmmoCount = _vehicle ammoOnPylon _x;
		_pylonLoadouts pushback [_x,_pylonWeapon,floor(_pylonAmmoCount/2)];
	} forEach _pylonNames;
	{
		//[format["pylonLoadouts dump: data = %1",_x]] call logStuff;
	} forEach _pylonLoadouts;
	_loadout = [_turretLoadout,_pylonLoadouts];
	_loadout
};

RRR_storeVehicleLoadoutHalfCapacity = {
	RRR_vehicleLoadout = [cursorTarget] call RRR_getVehicleLoadoutsHalfAmmoCounts;
};
diag_log format["RRR_getSaveLoadout: script compiled"];
