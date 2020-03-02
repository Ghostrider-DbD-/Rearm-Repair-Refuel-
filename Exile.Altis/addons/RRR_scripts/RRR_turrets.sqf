RRR_removeAllTurretMagazines = {
	params["_vehicle"];
	//_vehicle = cursorTarget;
	private _loadout = magazinesAllTurrets _vehicle;
	//[format["removeAllturretMags:[BEGIN] _vehicle %1 | _loadout %2",_vehicle,_loadout]] call logStuff;
	{
		_x params["_mag","_tur"];
		//[format["magazines in turret %1 before deletion = %2",_tur,_vehicle magazinesTurret _tur]];
		//[format["_mag %1 | _tur %2",_mag,_tur]] call logStuff;
		_vehicle removeMagazinesTurret [_mag,_tur];
		//[format["magazines in turret %1 after deletion = %2",_tur,_vehicle magazinesTurret _tur]];
	} forEach _loadout;
	//[format["removeAllturretMags:[END] _vehicle %1 | _loadout %2",_vehicle,magazinesAllTurrets _vehicle]] call logStuff;	
};

RRR_getCurrentTurretLoadout = {  //  Should be useful for saving vehicle loadouts for virtual garage/hanger/boatrack
	params["_vehicle"];	
	_loadout = magazinesAllTurrets _vehicle;
	_loadout
};

RRR_setTurretLoadouts = {  // Reserved for virtual garage (server side most likely)
	params["_vehicle","_loadout"];

	private _currTurretMagazines = _vehicle magazinesTurret _turret;
	{
		_vehicle removeMagazinesTurret [_x,_turret];
	} forEach _currTurretMagazines;	

	{
		_x params["_magClassname","_turret","_ammoCount"];
		_vehicle addMagazineTurret["_magClassname","_turret","_ammoCount"];	
	} foreach _loadout;
	true			
};

