
/*
RRR_canServiceFromDriverSeat = ["Ship"];
RRR_canServiceFromExterior = ["Car","Tank","Air","Ship"];
RRR_servicePointNearestFlag = 200;
*/

RRR_isServicableVehicle = {
	params["_vehicle",["_mode","external"]];
	private _typeOfVehicle = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass");
	//diag_log format["_typeOfVehicle = %1 | type in RRR_canRepairFromExterior",_typeOfVehicle,_typeOfVehicle in RRR_canRepairFromExterior];
	//private _legalVehicle = if (_vehicle isKindOf "Car" || _vehicle isKindOf "Tank" || _vehicle isKindOf "Ship" || _vehicle isKindOf "Air") then {true} else {false};
	//diag_log format["_isServicableVehicle: _mode = %4 | _vehicle %1 | typeOf _vehicle %2 | _typeOfVehicle %3",_vehicle,typeOf _vehicle,_typeOfVehicle,_mode];
	private _allowedCategories = [];
	switch (_mode) do 
	{
		case "external": {_allowedCategories = RRR_canRepairFromExterior};
		case "driver": {_allowedCategories = RRR_canServiceFromDriverSeat};
	};
	private _legalVehicle = if (_typeOfVehicle in _allowedCategories) then {true} else {false};
	//diag_log format["isServiceableVehicle: returning _legalVehicle = %1 for vehicle %2 of isKindOf %3 | _mode = %4 | _allowedCategories %5",_legalVehicle,_vehicle,_typeOfVehicle,_mode,_allowedCategories];
	_legalVehicle
};

RRR_handlePlayerNotifications = {
	params["_vehicle"];
/*
	RRR_refuelStationNearby = false;
	RRR_repairStationNearby = false;
	RRR_rearmStationNearby = false;
	RRR_servicePointNearby = false;
*/
	if (isNil "RRR_notificationsLastUpdate") then {RRR_notificationsLastUpdate = diag_tickTime};
	if (diag_tickTime - RRR_notificationsLastUpdate < 5) exitWith {};
	private _servicePoints = nearestObjects [_vehicle,RRR_servicePointTypes,RRR_RearmStationSearchDistanceNotifications];
	private _nearestFlag = nearestObject [player, "Exile_Construction_Flag_Static"];
	if (player distance _nearestFlag < RRR_servicePointNearestFlag) exitWith {};	
	if (_servicePoints isEqualTo []) then 
	{
		if (RRR_servicePointNearby) then 
		{
			RRR_servicePointNearby = false;
			["ErrorTitleAndText", ["Notice", format["You have left the service point"]]] call ExileClient_gui_toaster_addTemplateToast;
		};
	} else { 
		if !(RRR_servicePointNearby) then 
		{
			RRR_servicePointNearby = true;
			["SuccessTitleAndText", ["Notice", format["You are near a service point"]]] call ExileClient_gui_toaster_addTemplateToast;
		};
	};
	if !(RRR_servicePointNearby) then 
	{
		private _refuelPoints = [_vehicle] call RRR_getNearbyFuelSources;
		if (_refuelPoints isEqualTo []) then 
		{
			if (RRR_refuelStationNearby) then 
			{
				RRR_refuelStationNearby = false;
				["ErrorTitleAndText", ["Notice", format["You have left the fuel station"]]] call ExileClient_gui_toaster_addTemplateToast;
			};
		};
		if !(_refuelPoints isEqualTo []) then 
		{
			if !(RRR_refuelStationNearby) then 
			{
				RRR_refuelStationNearby = true;
				["SuccessTitleAndText", ["Notice", format["You are near a fuel station"]]] call ExileClient_gui_toaster_addTemplateToast;				
			};
		} else {

		};
	} else {

	};
};

RRR_getNearbyServicePoints = {
	params["_vehicle"];
	private _spDistance = RRR_spSearchDistanceLand;
	if (typeOf _vehicle isKindOf "Air") then {_rearmDistance = RRR_spSearchDistanceAir};
	if (typeOf _vehicle isKindOf "Ship") then {_rearmDistance = RRR_spSearchDistanceShip};
	private _spSources = nearestObjects [_vehicle,RRR_servicePointTypes,_spDistance];
	_spSources
};

RRR_manageServicePointsDriver = { 
	private _vehicle = vehicle player;
	//private _typeOfVehicle = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass ");
	//private _typeAllowed = _typeOfVehicle in ["Car","Air","Ship","Armored"];	
	private _serviceableVehicle = [_vehicle,"driver"] call RRR_isServicableVehicle;
	private _nearestFlag = nearestObject [player, "Exile_Construction_Flag_Static"];
	private _servicePoints = [_vehicle] call RRR_getNearbyServicePoints;
	if (/*!(_typeAllowed) ||*/ (vehicle player isEqualTo player)  || _servicePoints isEqualTo [] || !(_serviceableVehicle) || !(driver _vehicle isEqualTo player) || player distance _nearestflag < RRR_servicePointNearestFlag) exitWith 
	{
		player removeAction RRR_servicePointHandleDriver;
		RRR_servicePointHandleDriver = -1;		
	};
	if !(RRR_servicePointHandleDriver isEqualTo -1) exitWith {};  // 	
	private _img = "<img size='1.5'image='a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryweapon_ca.paa'/>"; 	
	RRR_servicePointHandleDriver = player addAction[format["%1<t color='#FF6347'>Service Point</t>",_img],{call RRR_editLoadout;},[_vehicle,"driver"]];
	if !(RRR_playerRepairActionHandle isEqualTo -1) then 
	{  //  This can happen with smaller boats and assumedly other small vehicles.
		player removeAction RRR_servicePointHandleDriver;
		RRR_servicePointHandleDriver = -1;
	};
};

RRR_manageServicePointsDriver = { //  iconrefuelat_ca.paa
	private _vehicle = vehicle player;
	private _serviceableVehicle = [_vehicle,"driver"] call RRR_isServicableVehicle;
	private _nearestFlag = nearestObject [position player, "Exile_Construction_Flag_Static"];
	private _nearFlag = if (isNull _nearestFlag || player distance _nearestflag < RRR_servicePointNearestFlag) then {false} else {true};
	private _servicePoints = [_vehicle] call RRR_getNearbyServicePoints;
	//diag_log format["manageServicePointsPlayer: _typeAllowed %1 | _servicableVehicle %2 | _servicePoints %3 | _nearFlag %4 | vehicle player %5","ignored",_serviceableVehicle,_servicePoints,_nearFlag,vehicle player];		
	if ((vehicle player isEqualTo player)  || _servicePoints isEqualTo [] || !(_serviceableVehicle) || !(driver _vehicle isEqualTo player) ||  player distance _nearestflag < RRR_servicePointNearestFlag) exitWith 
	{
		player removeAction RRR_servicePointHandleDriver;
		RRR_servicePointHandleDriver = -1;	
	};
	if !(RRR_servicePointHandleDriver isEqualTo -1) exitWith {};  // 	
	private _img = "<img size='1.5'image='\a3\Ui_f\data\IGUI\Cfg\Cursors\iconrefuelat_ca.paa'/>"; 		
	RRR_servicePointHandleDriver = player addAction[format["%1<t color='#FF6347'>Service Point</t>",_img],{call RRR_editLoadout},[cursorTarget,"external"]];
	if !(RRR_servicePointHandlePlayer isEqualTo -1) then 
	   // Ensure that the action for players is removed so that both are not shown
	{  //  This can happen with smaller boats and assumedly other small vehicles.
		player removeAction RRR_servicePointHandlePlayer;
		RRR_servicePointHandlePlayer = -1;
	};
};

RRR_manageServicePointsPlayer = {
	private _vehicle = cursorTarget;
	private _serviceableVehicle = [_vehicle,"external"] call RRR_isServicableVehicle;
	private _nearestFlag = nearestObject [position player, "Exile_Construction_Flag_Static"];
	private _nearFlag = if (isNull _nearestFlag || player distance _nearestflag < RRR_servicePointNearestFlag) then {false} else {true};
	//diag_log format["manageServicePointsPlayer: _nearestFlag = %1 | distance to _nearFlag = %2",_nearestFlag,_nearflag];
	private _servicePoints = [_vehicle] call RRR_getNearbyServicePoints;
	//diag_log format["manageServicePointsPlayer: _typeAllowed %1 | _servicableVehicle %2 | _servicePoints %3 | _nearFlag %4 | vehicle player %5","ignored",_serviceableVehicle,_servicePoints,_nearFlag,vehicle player];	
	if (/*!(_typeAllowed) ||*/ !(_serviceableVehicle) || (_servicePoints isEqualTo []) || !(vehicle player isEqualTo player) || _nearFlag) exitWith 
	{
		//diag_log format["manageServicePointsPlayer: removing action:  _servicableVehicle %1 | _servicePoints %2 | _nearFlag %3 | vehicle player %4","null",_serviceableVehicle,_servicePoints,_nearFlag,vehicle player];
		player removeAction RRR_servicePointHandlePlayer;
		RRR_servicePointHandlePlayer = -1;
	};
	if !(RRR_servicePointHandlePlayer isEqualTo -1) exitWith {};	
	/*
	_actionTitle = [format["Repair %1",getText (configFile >> "Cfgvehicles" >> typeOf _vehicle >> "displayName")], _costs] call _fnc_actionTitle;
     SP_repair_action = _vehicle addAction [format["<img size='1.5'image='\a3\Ui_f\data\IGUI\Cfg\Cursors\iconrepairvehicle_ca.paa'/> %1",_actionTitle], _folder + "service_point_repair.sqf", [_servicePoint, _costs, _repair_repairTime], -1, false, true, "", _actionCondition];
	*/
	private _img = "<img size='1.5'image='a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryweapon_ca.paa'/>";  //    
	RRR_servicePointHandlePlayer = player addAction[format["%1<t color='#FF6347'>Service Point</t>",_img],{call RRR_editLoadout},[cursorTarget,"external"]];
};

RRR_monitoring = {
	//[] call RRR_manageDriverRefuelActions;
	//[] call RRR_managePlayerRefuelActions;
	//[] call RRR_manageDriverRepairActions;
	//[] call RRR_managePlayerRepairActions;
	//[] call RRR_manageDriverRearmActions;
	//[] call RRR_managePlayerRearmActions;
	[] call RRR_manageServicePointsDriver;
	[] call RRR_manageServicePointsPlayer;
	[vehicle player] call RRR_handlePlayerNotifications	
	//["RRR_Monitoring"] call logStuff;
};

// Here only for testing in the Editor
RRR_mainLoop = {
	RRR_counter = 0;
	while {true} do 
	{
		uiSleep 1;
		[] call RRR_monitoring;
	};
};
