/*
	functions related to opening and updating the refuel/repair/rearm dialog
*/
#define comboControls [2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2113]
RRR_onLoadRearmDialog = {
	RRR_customLoadoutEditorEnabled = false;	

	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];
	private _displayName = getText(configFile >> "CfgVehicles" >> typeOf RRR_cursorTarget >> "DisplayName");
	private _displayPic = getText (configfile >> "CfgVehicles" >> typeOf RRR_cursorTarget >> "Components" >> "TransportPylonsComponent" >> "uiPicture");
	if (_displayPic isEqualTo "") then {_displayPic = getText(configFile >> "CfgVehicles" >> typeOf RRR_cursorTarget >> "editorPreview")};
	(_display displayCtrl 1003) ctrlSetText format["Servicing %1",_displayName];
	(_display displayCtrl 1200) ctrlSetText format["%1",_displayPic];
	private _turrets = [];
	private _turretWeapons = [];
	private _allowedWeaponMagazines = [];
	#define greyedOutText {0.7,0.7,0.7,0.7};
	#define greyedOutBackground {0.1,0.1,0.1,0.8};
	//_rearmPriceTurrets = [RRR_cursorTarget] call RRR_getRearmPriceTurrets;
	//_rearmPricePylons = [RRR_cursorTarget] call RRR_priceDefaultPylonLoadout;
	//private _price = _rearmPriceTurrets + _rearmPricePylons;
	// ctrl 1600 refuel
	
	private _mode = "external";
	if (vehicle player isEqualTo RRR_cursorTarget) then {_mode = "driver"};
	private _fuelSources = [RRR_cursorTarget] call RRR_getNearbyFuelSources;
	private _canRefuelVehicle = [RRR_cursorTarget,_mode] call RRR_isRefuelableVehicle;

	if (_fuelSources isEqualTo [] || !_canRefuelVehicle) then 
	{
		if (_fuelSources isEqualTo []) then 
		{
			_display displayCtrl 1600 ctrlSetTooltip "No Refuel Sources Nearby";
		};
		if (!_canRefuelVehicle && !(_fuelSources isEqualTo [])) then 
		{
			if !(local RRR_cursorTarget) then 
			{
				_display displayCtrl 1600 ctrlSetTooltip "Unable to Refuel: get into the drivers seat first";
				_display displayCtrl 1600 ctrlSetTextColor greyedOutText;
				_display displayCtrl 1600  ctrlSetBackgroundColor greyedOutBackground;
			};
		};
		//ctrlEnable[1600,false];
		buttonSetAction [1600,""];
	};
	// ctrl  1601 repair
	private _repairStations = [RRR_cursorTarget] call RRR_getNearbyRepairStations;
	private _canRepairVehicle = [RRR_cursorTarget,_mode]  call RRR_isRepairableVehicle;
	//[format["_vehicle %1 | _canRepairVehicle %2 | _repairStations %3",cursorTarget,_canRepairVehicle,_repairStations]] call logstuff;
	if (_repairStations isEqualTo [] || !_canRepairVehicle) then 
	{
		if (_repairStations isEqualTo []) then 
		{
			_display displayCtrl 1601 ctrlSetTooltip "No Repair Stations Nearby";
		};
		if (!_canRepairVehicle && !(_repairStations isEqualTo [])) then 
		{
			if !(local RRR_cursorTarget) then 
			{			
				_display displayCtrl 1601 ctrlSetTooltip "Unable to Repair: get into the drivers seat first";
				_display displayCtrl 1601 ctrlSetTextColor greyedOutText;
				_display displayCtrl 1601  ctrlSetBackgroundColor greyedOutBackground;
			};
		};
		//ctrlEnable[1601,false];
		buttonSetAction[1601,""];
	};
	// ctrl 1603 rearm 
	private _rearmStations = [RRR_cursorTarget] call RRR_getNearbyRearmStations;
	private _canRearm = [RRR_cursorTarget] call RRR_isRearmableVehicle;
	if (_rearmStations isEqualTo [] || !_canRearm) then 
	{
		if (_rearmStations isEqualTo []) then 
		{
			_display displayCtrl 1602 ctrlSetTooltip "No Rearm Stations Nearby";
			_display displayCtrl 1603 ctrlSetTooltip "No Rearm Stations Nearby";			
		};
		if !(local RRR_cursorTarget) then 
		{
			_display displayCtrl 1602 ctrlSetTooltip "Unable to Rearm: get into the drivers seat first";
			_display displayCtrl 1603 ctrlSetTooltip "Unable to Rearm: get into the drivers seat first";			
		};
		buttonSetAction[1602,""];
		buttonSetAction[1603,""];		
	};
	// ctrl 1604 customize 

	// diable comboboxes until we need them.
	{
		ctrlEnable[_x,false];
		ctrlShow[_x,false];
	} forEach comboControls;
	// RRR_loadoutPylons
	private _pylonNames = [RRR_cursorTarget] call RRR_allPylonNames;
	if (_pylonNames isEqualTo []) then 
	{
		ctrlEnable[1603,false];
		ctrlShow[1603,false];
	} else {
		[] call RRR_enableCustomizedLoadout;
	};
};

RRR_enableCustomizedLoadout = {
	RRR_loadoutPylons = [];
	RRR_loadoutTurrets = [];
	RRR_interfacePylons = [];
	RRR_interfaceTurrets = [];
	RRR_rearmPrice = 0;
	RRR_customLoadoutEditorEnabled = true;

	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];	
	_display displayCtrl 1602 ctrlSetTooltip "Rearm with Custom Loadout";
	buttonSetAction[1602,"closeDialog 0;call RRR_reloadCustomizedLoadout;"];
	// enable comboboxes until we need them.
	private _pylons = [RRR_cursorTarget] call RRR_allPylonNames;
	//[format["count _pylons = %1 | _pylongs = %2",count _pylons,_pylons]] call logStuff;
	private _comboControls = comboControls;
	//[format["customizeLoot: _pylons = %1",_pylons]] call logStuff;

	{	
		private _pylonName = _x;  //_pylons select (_i);
		private _ctrlNo = _comboControls deleteAt 0;
		RRR_interfacePylons pushBack [_pylonName,_ctrlNo];
		ctrlEnable[_ctrlNo,true];
		ctrlShow[_ctrlNo,true];		
		private _uiPos = getArray(configFile >> "CfgVehicles" >> typeOf RRR_cursorTarget >> "Components" >> "TransportPylonsComponent" >> "pylons" >> _pylonName >> "UIposition");

		if (_uiPos isEqualTo []) then {_uiPos = [0,0,0,0]};
		//[format["pylon # %3 | _pylonName %4 | _ctrl = %1 | UIPos = %2",_ctrlNo,_uiPos,_forEachIndex,_pylonName]] call logStuff;
		if (typeName (_uiPos select 0) isEqualTo "STRING") then // Needed for CUP or other variants that do not provide these data as valuse
		{
			private _val = if (true) then {call compile (_uiPos select 0)};
			//diag_log format["_uiPos select 0 %1 | _val %2",_uiPos select 0,_val];
			_uiPos set[0,_val];
		};
		if (typeName (_uiPos select 1) isEqualTo "STRING") then // Needed for CUP or other variants that do not provide these data as valuse
		{
			private _val = if (true) then {call compile (_uiPos select 1)};
			//diag_log format["_uiPos select 0 %1 | _val %2",_uiPos select 0,_val];
			_uiPos set[1,_val];
		};
		diag_log format["_uiPos = %1 | %2 | %3",_uiPos,typeName (_uiPos select 0), typeName (_uiPos select 1)];		
		if (typeOf RRR_cursorTarget isKindOf ["Helicopter",configFile >> "CfgVehicles"]) then 
		{
			(_display displayCtrl _ctrlNo) ctrlSetPosition [  // credit to polpox for this little bit of code, mainly the constants therein
					safeZoneX + safeZoneW * 3/8 - 0.11 + (_uiPos select 0),
					safeZoneY + safeZoneH * 0.44  + (_uiPos select 1),
					0.12,
					0.035			
			];	
		};
		if (typeOf RRR_cursorTarget isKindOf["Plane",configFile >> "CfgVehicles"]) then 
		{
			(_display displayCtrl _ctrlNo) ctrlSetPosition [  // credit to polpox for this little bit of code, mainly the constants therein
					safeZoneX + safeZoneW * 3/8 - 0.10 + (_uiPos select 0),
					safeZoneY + safeZoneH * 0.355  + (_uiPos select 1),
					0.12,
					0.035	
			];
		};
		(_display displayCtrl _ctrlNo) 	ctrlCommit 0;
		//    vehicle getCompatiblePylonMagazines string/index
		private _allowedAmmo = (RRR_cursorTarget getCompatiblePylonMagazines _pylonName);
		private _defaultAmmo = [typeOf RRR_cursorTarget,_pylonName] call RRR_defaultMagazinePylon;
		private _lbCursorPos = -1;
		private _tabs = "exile_assets\texture\ui\poptab_trader_ca.paa";
		//lbAdd[_ctrlNo,"<empty>"];  //  Leave blank for now
		{
			private _magClassName = _x;
			private _ammoName = getText(configFile >> "CfgMagazines" >> _magClassName >> "displayName");	
			private _ammoPicture = getText(configFile >> "CfgMagazines" >> _magClassName >> "picture");		
			//[format["Class %3 |Name %1 | count Picture %4 |Picture %2",_ammoName,_ammoPicture,_magClassName,count _ammoPicture]] call logStuff;
			private _index = lbAdd[_ctrlNo,_ammoName];
			private _price = [_magClassName] call RRR_getMagazinePrice;			
			lbSetData[_ctrlNo,_index,_magClassName];
			lbSetValue[_ctrlNo,_index,_price];
			//[format["magName %1 | default mag %2",_magClassName,_defaultAmmo]] call logStuff;
			if (_magClassName isEqualTo _defaultAmmo) then 
			{
				lbSetToolTip [_ctrlNo,_index,format["%1 Tabs [DEFAULT]",_price]];
				lbSetColor[_ctrlNo,_Index,[0.17, 1.00, 0.38,1]];
				lbSetCurSel [_ctrlNo,_index];

			} else {
				lbSetToolTip [_ctrlNo,_index,format["%1 Tabs",_price]];
			};
			//[format["customizeLoadout: _ctrl %1 | index %2 | data %3 | value %4",_ctrlNo,_index,lbData[_ctrlNo,_index],lbValue[_ctrlNo,_index]]] call logStuff;
		} forEach _allowedAmmo;
	} forEach _pylons;
	(_display displayCtrl 1603) ctrlSetTooltip "Use Default Loadout";
	buttonSetAction [1603,"call RRR_enableDefaultLoadout;"]; 
	[] call RRR_updateCustomLoadout;
};

RRR_enableDefaultLoadout = {
	RRR_customLoadoutEditorEnabled = false;
	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];		
	(_display displayCtrl 1603) ctrlSetTooltip  "Customize Loadout";
	(_display displayCtrl 1602) ctrlSetToolTip "Rearm with Default Loadout";
	buttonSetAction [1603,"call RRR_enableCustomizedLoadout;"]; 
	// diable comboboxes until we need them.
	{
		ctrlEnable[_x,false];
		ctrlShow[_x,false];
	} forEach [2100,2101,2102,2103,2104,2105,2106,2107,2108];	
	[] call RRR_onLoadRearmDialog;
};

RRR_doRearm = {  // This is a fairly long script in order to properly track the price across multiple loops.
	private _vehicle = RRR_cursorTarget;

	private _baseRearmPrice = 0;
	private _abort = false;
	if (toLower(RRR_rearmMode) isEqualTo "pervehicle") then 
	{
		_baseRearmPrice = [_vehicle] call RRR_getBaseRearmPrice;
		if (_baseRearmPrice > player getVariable["ExileMoney",0]) then 
		{
				private _m = format["You need %1 more tabs to rearm",_baseRearmPrice - (player getVariable["ExileMoney",0])];
				["InfoTitleAndText", ["Insufficient Funds", _m]] call ExileClient_gui_toaster_addTemplateToast;	
				//systemchat format["InsufficientFunds, %1",_m];
				_abort = true;
				uiSleep 2;
		};
	};
	if (RRR_rearmMode isEqualTo "") then 
	{
		private _price = [_vehicle] call RRR_getRearmPrice;
		if (player getVariable["ExileMoney",0] isEqualTo 0) then 
		{
			abort = true;
			private _m = format["You need %1 more tabs to rearm",_price - (player getVariable["ExileMoney",0])];
			["InfoTitleAndText", ["Insufficient Funds", _m]] call ExileClient_gui_toaster_addTemplateToast;	
			//systemChat format["Insufficient Funds, Rearming will proceed as funds allow"];
		} else {
			if (_price > player getVariable["ExileMoney",0]) then 
			{
				private _m = format["You need %1 more tabs to fully rearm",_price - (player getVariable["ExileMoney",0])];
				["InfoTitleAndText", ["Insufficient Funds", _m]] call ExileClient_gui_toaster_addTemplateToast;		
				uiSleep 3;	
				["InfoTitleAndText", ["", "Rearming will proceed as funds allow"]] call ExileClient_gui_toaster_addTemplateToast;
				//systemChat format["Insufficient Funds, Rearming will proceed as funds allow"];
				uisleep 3;
			};
		};
	};
	if (_abort) exitWith {};

	/*
		 Reload Turrets waypointAttachedVehicle the player has sufficient tabs.
	*/
	[_vehicle] call RRR_removeAllTurretMagazines;
	private _vehicleDisplayName = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
	private _m = format[" turrets on %1",_vehicleDisplayName,_vehicle];
	["InfoTitleAndText", ["Rearming", _m]] call ExileClient_gui_toaster_addTemplateToast;	
	private _price = 0;  // tracked and cummulative through each of the loops below
	private _turrets = allTurrets[_vehicle,true];
	_turrets pushBackUnique [-1];
	//[format["allTurrets = %1",_turrets]] call logStuff;
	{
		private _pos = 1;
		private _turret = _x;
		private _turretName = getText([_vehicle,_x] call BIS_fnc_turretConfig >> "gunnerName");
		private _defaultMagazines = getArray([_vehicle,_x] call BIS_fnc_turretConfig >> "Magazines");
		private _defaultMagazineNumber = count _defaultMagazines;
		private _turretWeapons = getArray([_vehicle,_x] call BIS_fnc_turretConfig >> "Weapons");
		private _currTurretMagazines = _vehicle magazinesTurret _x;
		{
			_vehicle removeMagazinesTurret [_x,_turret];
		} forEach _currTurretMagazines;	
		{
			private _mag = _x;
			private _magPrice = [_mag] call RRR_getMagazinePrice;
			if (_price + _magPrice > player getVariable["ExileMoney",0]) exitWith 
			{
				["InfoTitleAndText", ["ERROR", "Insufficient Funds to Continue Rearming"]] call ExileClient_gui_toaster_addTemplateToast;
				_abort = true;
				uiSleep 2;
			};
			if !(_abort) then 
			{
				private _magDisplayName = getText(configFile >> "CfgMagazines" >> _mag >> "displayName");
				_vehicle addMagazineTurret [_mag,_turret];	
				_m = format["Adding %1 to %2",_magDisplayName,_turretName];			
				_price = _price + _magPrice;
				//[format["Rearming turret %1 with %2 at price of %3",_turretName,_mag,_price]] call logStuff;
				["InfoTitleAndText", ["Rearming", _m]] call ExileClient_gui_toaster_addTemplateToast;	
			uisleep 1;			
			};
		} foreach _defaultMagazines;		
	} forEach _turrets;	
	/*
		Done reloading Turrets 
	*/

	/*
		Reload any pylons
	*/
	if !(_abort) then 
	{
		private _m = format[" Pylons on %1",_vehicleDisplayName,_vehicle];
		["InfoTitleAndText", ["Rearming", _m]] call ExileClient_gui_toaster_addTemplateToast;	
		if (RRR_customLoadoutEditorEnabled) then 
		{
			// configure loadouts according to setting in the display
			[_vehicle] call RRR_clearPylonLoadouts;		
			uisleep 2;
			{
				_x params["_pylonName","_magName"];
				_vehicle setPylonLoadOut [_pylonName,_magName];
				private _magPrice = [_magName] call RRR_getMagazinePrice;
				if (_price + _magPrice > player getVariable["ExileMoney",0]) exitWith 
				{
					["InfoTitleAndText", ["ERROR", "Insufficient Funds to Continue Rearming"]] call ExileClient_gui_toaster_addTemplateToast;
					uiSleep 2;
					_abort = true;
				};
				if !(_abort) then 
				{
					_price = _price + _magPrice;
					uiSleep 1;
					_m = format["%1 with %2",_pylonName,_magName];
					//[_m] call logStuff;
					["InfoTitleAndText", ["Rearming", _m]] call ExileClient_gui_toaster_addTemplateToast;		
				};
			} forEach RRR_loadoutPylons;
		} else {
			// Setup with the default loadout for the pylons.
			[_vehicle] call RRR_clearPylonLoadouts;	
			uisleep 2;
			private _pylons = [_vehicle] call RRR_allPylonNames;
			{
				private _mag = [typeOf _vehicle,_x] call RRR_defaultMagazinePylon;
				private _magPrice = [_mag] call RRR_getMagazinePrice;
				if (_price + _magPrice > (player getVariable["ExileMoney",0])) then 
				{
					["InfoTitleAndText", ["ERROR", "Insufficient Funds to Continue Rearming"]] call ExileClient_gui_toaster_addTemplateToast;	
					uiSleep 2;
					_abort = true;
				};
				if !(abort) then 
				{
					_vehicle setPylonLoadout [_x,_mag];
					private _magName = getText(configFile>> "CfgMagazine" >> _mag >> "displayName");
					private _pylonName = format["%1",_forEachIndex];			
					_price = _price + _magPrice;
					//[format["_vehicleDisplayName %1 | _pylonName %2 | _magName %3 | _mag %4",_vehicleDisplayName,_forEachIndex,_magName,_mag]] call logStuff;
					private _m = format["Pylon %1 with %2",_pylonName,_magName];
					["InfoTitleAndText", ["Rearming", _m]] call ExileClient_gui_toaster_addTemplateToast;	
					uisleep 1;
				};
			} forEach _pylons;
		};
	};
	/*
		Done reloading pylons 
	*/
	
	/*
		Deal with costs of rearm 
	*/
	if (toLower(RRR_rearmMode) isEqualTo "pervehicle") then  
	{
		_price = _baseRearmPrice;
	};
	if (_price > 0) then 
	{
		//[format["doRearm: updating player tabs with _price = %1 | _tabs = %2",_price,player getVariable["ExileMoney",0]]] call logStuff;		
		["giveTakePlayerTabsRequest",[player,(-1) * _price]] call ExileClient_system_network_send;
	};
	IF !(_abort) then 
	{
		["<t size='22' font='PuristaMedium'>Vehicle Rearmed!</t>", [1, 0, 0, 1]] call ExileClient_gui_toaster_addToast;
	};
	RRR_actionInProgress = false;	
};

RRR_reloadCustomizedLoadout = {
	[] spawn RRR_doRearm;
};

RRR_hidePriceControl = {
	ctrlShow[1100 ,false];
};

RRR_getMagazinePrice = {
	params["_mag"];
	private _price = getNumber(missionConfigFile >> "RRR_AmmoCost"  >> _mag >> "price");
	if (_price isEqualTo 0) then {_price = RRR_defaultRearmMagazinePrice};
	//[format["getMagazinePrice: _mag %1 | _price %2",_mag,_price]] call logStuff;
	_price
};

RRR_getRearmPriceTurrets = {
	params["_vehicle"];
	private _turrets = (allTurrets[_vehicle,true]);
	_turrets pushback [-1];
	//[format["turrets for vehicle %1 = %2",_vehicle,_turrets]] call logStuff;
	_totalCost = 0;	
	{
		private _turret = _x;
		private _defaultMags = getArray ([_vehicle, _turret] call BIS_fnc_turretConfig >> "magazines");	
		//[format["vehicle %1 | turret %2 | default mags %3",_vehicle,_x,_defaultMags]] call logStuff;		
		{
			_magCost = [_x] call RRR_getMagazinePrice;
			_totalCost = _totalCost + _magCost;
		} foreach _defaultMags
	} forEach _turrets;
	if (_totalCost isEqualTo 0) then {_totalCost = 25};
	_totalCost
};

RRR_customPylonLoadoutPrice = {
	private _price = 0;
	{
		_x params["_pylonName","_ctrlNo"];
		private _ctrl = _x;
		private _index = lbCurSel _ctrlNo;
		_price = _price + lbValue[_ctrlNo,_index];  // can we do something with index here ?

	} forEach RRR_interfacePylons;
	//[format["pylonLoadoutPrice: %1",_price]] call logStuff;
	RRR_rearmPricePylons = _price;
	_price
};

RRR_getPriceDefaultPylonLoadout = {
	params["_vehicle"];
	private _pylons = [_vehicle] call RRR_allPylonNames;
	//[format["getPriceDefaultPylonLoadout:  vehicle %1 | pylonNames %2",_vehicle,_pylons]] call logstuff;
	private _tabs = 0;

	{
		private _pylon = _x;
		private _mag = [typeOf _vehicle,_pylon] call RRR_defaultMagazinePylon;
		private _price = getNumber(missionConfigFile >> "RRR_AmmoCost" >> _mag >> "price");
		//[format["getPriceDefaultPylonLoadout:  mag %1 |price %2",_mag,_price]] call logStuff;
		_tabs = _tabs + _price;
	} foreach _pylons;
	_tabs
};

RRR_getBaseRearmPrice = {
	params["_vehicle"];
	private _baseRearmPrice = 0;
	private _vType = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass");
	if (_vType in ["Car"]) then {_baseRearmPrice = RRR_RearmPriceCars};
	if (_vType in ["Armored"]) then {_baseRearmPrice = RRR_RearmPriceTanks};
	if (_vType in ["Air"]) then {_baseRearmPrice = RRR_RearmPriceAir};
	if (_vType in ["Ship"]) then {_baseRearmPrice = RRR_RearmPriceShips};	
	_baseRearmPrice
};

RRR_getRearmPrice = {
	//[format["getRearmPrice = %1",diag_tickTime]] call logStuff;
	params ["_vehicle"];
	private _totalCost = 0;
	if (toLower(RRR_rearmMode) isEqualTo "pervehicle") then 
	{
		_totalCost = [_vehicle] call RRR_getBaseRearmPrice;	
	} else {
		if (RRR_customLoadoutEditorEnabled) then 
		{
			private _pylonsRearmPrice = [RRR_cursorTarget] call RRR_customPylonLoadoutPrice;
			private _turretsRearmPrice = [RRR_cursorTarget] call RRR_getRearmPriceTurrets;
			_totalCost = _pylonsRearmPrice + _turretsRearmPrice;
			//[format["getRearmPrice: _pylonsRearmPrice %1 | RRR_rearmPriceTurrets = %2 |_totalCost %3",_pylonsRearmPrice,_turretsRearmPrice,_totalCost]] call logStuff;
		} else {
			private _pylonsRearmPrice = [RRR_cursorTarget] call RRR_getPriceDefaultPylonLoadout;
			private _turretsRearmPrice = [RRR_cursorTarget] call RRR_getRearmPriceTurrets;
			_totalCost = _pylonsRearmPrice + _turretsRearmPrice;
			//[format["getRearmPrice: _pylonsRearmPrice %1 | RRR_rearmPriceTurrets = %2 |_totalCost %3",_pylonsRearmPrice,_turretsRearmPrice,_totalCost]] call logStuff;
		};
	};
	_totalCost
};

RRR_updateCtrlRearmPrice = {
	//[format["updating price display control with vehicle = %1",RRR_cursorTarget]] call logStuff;
	ctrlShow[1100,true];
	private _price = [RRR_currentTarget] call RRR_getRearmPrice;
	//[format["Updated Rearm Price = %1",_price]] call logStuff;
	private _priceInfo = format["Rearm Cost %1 TABS",_price];
	//[format["Updated Rearm _priceInfo = %1",_priceInfo]] call logStuff;	
	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];
	if (_price <= player getVariable["ExileMoney",0]) then
	{
		(_display displayCtrl 1100) ctrlSetStructuredText parseText _priceInfo;
		//buttonSetAction [1100, "closeDialog 0; call RRR_doVehicleRearmDialog;"];
	} else {
		(_display displayCtrl 1100) ctrlSetStructuredText parseText format["%1 TABS needed to rearm",_price - (player getVariable["ExileMoney",0])];
		//buttonSetAction [1100,""];
	};
};

RRR_updateCustomLoadout = {

	//private _pylonName = _x;  //_pylons select (_i);
	//private _ctrlNo = _comboControls deleteAt 0;
	//RRR_interfacePylons pushBack [_pylonName,_ctrlNo];
	RRR_loadoutPylons = [];
	{
		_x params["_pylonName","_ctrlNo"];
		private _pylonWeapon = lbData[_ctrlNo,lbCurSel _ctrlNo];
		RRR_loadoutPylons pushBack [_pylonName,_pylonWeapon];
	} foreach RRR_interfacePylons;
	//{
		//[format["pylon %1 updated to %2",_x select 0,_x select 1]] call logStuff;
	//} forEach RRR_loadoutPylons;
};

RRR_updateCtrlRepairPrice = {
	ctrlShow[1100,true];
	private _price = [RRR_cursorTarget] call RRR_getRepairPrice;
	private _priceInfo = "";
	if (_price > (player getVariable["ExileMoney",0])) then 
	{
		_priceInfo = format["%1 Tabs needed for repairs",_price - (player getVariable["ExileMoney",0])];
		//_m = ['Warning', ['Insufficient Funds']] call ExileClient_gui_toaster_addTemplateToast;
		buttonSetAction[1601,"['InfoTitleAndText', ['Error','Insufficient Funds']] call ExileClient_gui_toaster_addTemplateToast;"];  // disable this since there are insufficient funds
	} else {
		_priceInfo = format["Repair Cost %1 TABS",_price];
	};
	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];
	(_display displayCtrl 1100) ctrlSetStructuredText parseText _priceInfo;
};

RRR_updateCtrlRefuelPrice = {
	ctrlShow[1100,true];
	private _litersToAdd = [RRR_cursorTarget] call RRR_litersToAdd;
	private _price = [RRR_cursorTarget] call RRR_getRefuelPrice; // [RRR_cursorTarget] call RRR_fnc_getRearmPrice;
	private _priceInfo = format["Refuel Cost %1 TABS",_price];
	private _display = uiNameSpace getVariable ["rearmVehicledialog", displayNull];
	(_display displayCtrl 1100) ctrlSetStructuredText parseText _priceInfo;
	if (player getVariable["ExileMoney",0] isEqualTo 0 && _price > 0) then 
	{
		buttonSetAction[1600,"['InfoTitleAndText', ['Error','Insufficient Funds']] call ExileClient_gui_toaster_addTemplateToast;"]; // since you can not refuel
	};
};

RRR_loadoutSelectionChanged = {
	//params ["_control", "_selectedIndex"];
	[] call RRR_updateCtrlRearmPrice;
	[] call RRR_updateCustomLoadout;
};

RRR_doVehicleRefuelDialog = { // called upon closing the repari/refuel/rearm dialog with refuel selected
	[RRR_cursorTarget,'external'] spawn RRR_doVehicleRefuel;
};


RRR_doVehicleRepairDialog = {  // call upon closing the repair/refuel/rearm dialog.
	[RRR_cursorTarget,'external'] spawn RRR_doVehicleRepair;
};

RRR_doVehicleRearmDialog = {
	[RRR_cursorTarget,'external'] spawn RRR_doRearm;
};

RRR_editLoadout = {
	RRR_cursorTarget = cursorTarget;
	if !(local RRR_cursorTarget) exitWith 
	{
		["ErrorTitleAndText", ["ABORTED", format["You must get into the driver's seat first"]]] call ExileClient_gui_toaster_addTemplateToast;
	};	
	disableSerialization;
	createDialog "rearmVehicledialog";
};
