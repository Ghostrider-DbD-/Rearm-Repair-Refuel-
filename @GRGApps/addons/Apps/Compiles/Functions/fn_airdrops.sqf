//GRGApps_fnc_airdrops = {
		params["_player","_mode","_index","_pin",["_testing",true]];
		//diag_log format["fn_airdrops: _this = %1",_this];
		//diag_log format["fn_airdrops: _player %1 | _mode %2 | _index %3 | _pin %4 | _testing %5",_pos,_mode,_index,_pin,_testing];		
		private _payloadObject = objNull; 
		private _allowDamage = false;
		private _aircraftType = getText(missionConfigFile >> "CfgAirdropForRespect" >> "aircraftType"); 
		private _visibleMarker = getNumber(missionConfigFile >> "CfgAirdropForRespect" >> "visibleMarker") == 1;
		private _mapMarker = getNumber(missionConfigFile >> "CfgAirdropForRespect" >> "mapMarker") == 1;
		private _mapMarkerDeleteTime = getNumber(missionConfigFile >> "CfgAirdropForRespect" >> "mapMarkerDeleteTime");
		private _spawnDistance = getNumber(missionConfigFile >> "CfgAirdropForRespect" >> "spawnDistance");
		
		//diag_log format["GRG_callAirdropSupplies: _pos %1 | _mode %2 | _index %3",_pos,_mode,_index];
		//diag_log format["supplyDropBoxType =%1",getText(missionConfigFile >> "CfgAirdropForRespect" >> "supplyDropBoxType")];
		//diag_log format["aircraftType =%1",_aircraftType]; // aircraftType
		//diag_log format["visibleMarker = %1",_visibleMarker];
		//diag_log format["mapMarker = %1",_mapMarker];
		//diag_log format["mapMarkerDeleteTime = %1",_mapMarkerDeleteTime];
		//diag_log format["spawnDistance = %1",_spawnDistance];
		//diag_log format["isClass rifleSupplies = %1",isClass(missionConfigFile >> "CfgAirdropForRespect" >> "CfgAirdropedSupplies" >> "rifleSupplies")];
		
		switch (_mode) do 
		{
			case "vehicles": {
				private _vehicles = getArray(missionConfigFile >> "CfgAirdropForRespect" >> "vehicleDropTypes");	
				private _vehType = (_vehicles select _index) select 2;
				//params["_className", "_position", "_direction", "_usePositionATL", "_pinCode"];
				//diag_log format["_vehilcle %1 selected from array %2",_vehType,_vehicles];
				_payloadObject = [_vehType,[0,0,0],0,true,_pin] call ExileServer_object_vehicle_createPersistentVehicle;
				_payloadObject setVariable ["ExileOwnerUID", (getPlayerUID _player)];
				_payloadObject setVariable ["ExileIsLocked",0];
				_payloadObject lock 0;
				_payloadObject call ExileServer_object_vehicle_database_insert;
				_payloadObject call ExileServer_object_vehicle_database_update;				
				_payloadObject allowDamage false;
				//_allowDamage = true;
				//diag_log format["_airdropVehicles: vehicle %1 of type %2 spawned",_payloadObject,_vehType];
			};
			case "supplies": {
				private _cargoBoxType = getText(missionConfigFile >> "CfgAirdropForRespect" >> "supplyDropBoxType");
				//diag_log format["_cargoBoxType = %1",_cargoBoxType];
				_payloadObject = [_cargoBoxType] call GMS_fnc_spawnPayload;
				_payloadObject allowDamage false;

				private _suppliesAirdrops = getArray(missionConfigFile >> "CfgAirdropForRespect" >> "supplyDropTypes");
				//diag_log format["supplyDropTypes = %1",_suppliesAirdrops];
				private _supplyDropParameters = (_suppliesAirdrops select _index);
				//diag_log format["index %1 | loadout %2",_index,_supplyDropParameters];
				private _loadoutConfig = getArray(missionConfigFile >> "CfgAirdropForRespect" >> _supplyDropParameters select 2);
				//diag_log format["_loadoutConfig = %1",_loadoutConfig];
				private _mags = getNumber(missionConfigFile >> "CfgAirdropForRespect" >> "magsToAdd");
				//diag_log format["_mags = %1",_mags];
				[_payloadObject,_loadoutConfig,_mags] call GMS_fnc_addItemsFromArray;
				//diag_log format["_payloadObject inventory = %1",[_payloadObject] call BIS_fnc_inv];
			};
		};
		if !(_testing) then 
		{
			_payloadObject allowDamage false;
			// params["_airdropPos","_aircraftClassName","_payload",["_allowDamage",true],["_visibleMarker",true],["_mapMarker",true],["_mapMarkerDeleteTime",3000],["_spawnDistance",2000]];
			_allowDamage = false;  // make helicopter god-moded
			[getPosATL _player,_aircraftType,_payloadObject,_allowDamage,_visibleMarker,_mapMarker,_mapMarkerDeleteTime,_spawnDistance] call GMS_fnc_flyInCargoToLocation;
		} else {
			//diag_log format["fn_airdrops: setting location of crate %1 to that of player %2 at %3",_payloadObject,_player,position _player];
			_payloadObject setPosATL (_player getPos[2,random(359)]);
			//diag_log format["fn_airdrops: position of crate set to %1, with player nearby at  %2",position _payloadObject,position _player];
		};
