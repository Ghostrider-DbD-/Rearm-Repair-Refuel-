/*
	Exile Network Functions to support GRG apps:
	Respect to Tabs 
	Level 7 Trading 
	Purchase Airdrops using Respect . 


*/

//diag_log "Initializing GRGApps\Functions";

ExileServer_GRGApps_network_giveTakePlayerRespectRequest  = {
	params["_sessionID","_parameters"];  // 
    //diag_log format["network_giveTakePlayerRespect Called with _this = %1",_this];
	_parameters params["_player","_respect"];	
    private _success = [_player,_respect] call GMS_fnc_giveTakeRespect;
	//  giveTakePlayerRespectResponse
	[_player,"giveTakePlayerRespectResponse",[true,_respect]] call ExileServer_system_network_send_to;
};

ExileServer_GRGApps_network_giveTakePlayerTabsRequest  = {
	params["_sessionID","_parameters"]; 	
	_parameters params["_player","_tabs"];
    //diag_log format["network_giveTakePlayerTabs Called with _player = %1 | _tabs = %2",_player,_tabs];
     [_player,_tabs] call GMS_fnc_giveTakeTabs;
	 [_player,"giveTakePlayerTabsResponse",[true,_tabs]] call ExileServer_system_network_send_to;
};

ExileServer_GRGApps_network_purchaseLevel7Request = {
	params["_sessionID","_parameters"];  // _parameters
	_parameters params["_player","_respect"];
	diag_log format["networked function ExileServer_GRGApps_network_purchaseLevel7Request called with _this = %1",_this];	
    [_sessionID,[_player,(_respect) * -1]] call ExileServer_GRGApps_network_giveTakePlayerRespectRequest;
	private _level7 = getNumber(missionConfigFile >> "CfgLevel7TradingConfiguration" >> "durationLevel7");

	// Update Database 
	format["updatePlayerLevel7:%1:%2",_level7,getPlayerUID _player] call ExileServer_system_database_query_fireAndForget;

	// Update client variables 
	[_sessionID,"updateLevel7TimeRemainingResponse", [_level7]] call ExileServer_system_network_send_to; 

	// Send notification of outcome  [assumption = there is enough respect for the request]
	diag_log format["ExileServer_GRGApps_network_purchaseLevel7Request: Level7 Trading Access purchased for player %1 at cost of %2 for %3 seconds",_player,_respect,_level7];
	// response goes here	
	[_player,"purchaseLevel7Response", [true,_level7]] call ExileServer_system_network_send_to; 	
};

ExileServer_GRGApps_network_getLevel7TradingTimeRequest = {
	//  read value from player object which was set when the player object was initalized
	// pass that back to the client 
	params["_player"];
	private _level7timeRemaining = format["loadPlayerLevel7:%1",_player getVariable "ExileOwnerUID"] call ExileServer_system_database_query_selectSingle;
	diag_log format["ExileServer_GRGApps_network_getLevel7TradingTimeRequest: _level7TimeRemaining = %1",_level7timeRemaining];
	[_player,"getLevel7TradingTimeResponse",[_level7TimeRemaining]] call ExileServer_system_network_send_to; 
};

ExileServer_GRGApps_network_updateLevel7TradingTimeRequest = {
	params["_player","_level7TimeRemaining"];

	if (_level7TimeRemaining < 0) then {_level7TimeRemaining = 0};
	_player setVariable["level7",_level7TimeRemaining];
	[format["updatePlayerLevel7:%1:%2",_level7TimeRemaining,_player getVariable "ExileOwnerUID"]] call ExileServer_system_database_query_fireAndForget;
	diag_log format["ExileServer_GRGApps_network_updateLevel7TradingTimeRequest: _player %1 | level7 updated to %2",_player, _player getVariable "level7"];
	[_player,"updateLevel7TradingTimeResponse",[true]] call ExileServer_system_network_send_to; 
};

ExileServer_GRGApps_network_purchaseAirdropWithRespectRequest = {
	params["_sessionID","_parameters"];  // _parameters
	_parameters params["_player","_mode","_index","_pin","_price","_testing"];
	//diag_log format["airdropRequest called with _this = %1",_this];
     [_sessionID,[_player,(_price) * -1]] call ExileServer_GRGApps_network_giveTakePlayerRespectRequest;	
	 //diag_log format["missionNamespace getVariable[GRGApps_fnc_airdrops,failed] = %1",missionNamespace getVariable["GRGApps_fnc_airdrops","failed"]];
	[_player,_mode,_index,_pin,_testing] call GRGApps_fnc_airdrops;  // Note to self: the code is client-side for now till I figure out how to include a file from the mission.pbo on the server.
	// response goes here
	[_player,"purchaseAirdropResponse",[true,_mode]] call ExileServer_system_network_send_to; 
};

ExileServer_GRGApps_network_respectToTabsRequest = {
	params["_sessionID","_parameters"];
	//diag_log format["respectToTabsRequest called: _this = %1",_this];
	_parameters params["_player","_respect","_tabs"];
	//[_player,(_respect) * -1] call GMS_fnc_giveTakeRespect;
	[_sessionID,[_player,_respect]] call ExileServer_GRGApps_network_giveTakePlayerRespectRequest;
	//[_player,_tabs] call GMS_fnc_giveTakeTabs;
	[_sessionID,[_player,_tabs]] call ExileServer_GRGApps_network_giveTakePlayerTabsRequest;
	[_player,"respectToTabsResponse",[true]] call ExileServer_system_network_send_to; 	
};

diag_log "GRGApps\Networked Functions initialized";