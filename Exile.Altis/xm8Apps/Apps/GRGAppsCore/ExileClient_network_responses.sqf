
ExileClient_GRGApps_network_giveTakePlayerRespectResponse = {
    params["_success","_respectChange"];
	if (_success) then 
	{
        if (_respectChange > 0) then 
        {
		    ["SuccessTitleAndText", ["Respect Updated", format["% Respect Points Added",_respectChange]]] call ExileClient_gui_toaster_addTemplateToast;
        } else {
		    ["SuccessTitleAndText", ["Respect Updated", format["% Respect Points Removed",_respectChange]]] call ExileClient_gui_toaster_addTemplateToast;
        };
	} else {
		["ErrorTitleAndText", ["ERROR", format["Something went wrong; %",_msg]]] call ExileClient_gui_toaster_addTemplateToast;
	};    
};

ExileClient_GRGApps_network_giveTakePlayerTabsResponse = {
    params["_success","_tabsChange"];
	//[format["tabsResponse: _tabsChange = %1",_tabsChange]] call logStuff;
	if (_success) then 
	{
        if (_tabsChange > 0) then 
        {
		    ["SuccessTitleAndText", ["Tabs Updated", format["%1 Tabs were added",_tabsChange]]] call ExileClient_gui_toaster_addTemplateToast;
        } else {
		    ["SuccessTitleAndText", ["Tabs Updated", format["%1 Tabs were removed",abs(_tabsChange)]]] call ExileClient_gui_toaster_addTemplateToast;
        };
	} else {
		["ErrorTitleAndText", ["ERROR", format["Something went wrong; %",_msg]]] call ExileClient_gui_toaster_addTemplateToast;
	};   
};

ExileClient_GRGApps_network_purchaseLevel7Response = {
	params["_success","_level7TimeRemaining"];
	diag_log format["networked function level7Response called with _this select 0 = %1",_this select 0];
 
	if (_success) then 
	{
		["SuccessTitleAndText", ["LEVEL 7", format["Access to Level 7 Traders for %1 Hours",_level7TimeRemaining / (60 * 60) /* time in minutes */]]] call ExileClient_gui_toaster_addTemplateToast;	
	} else {
		["ErrorTitleAndText", ["ERROR", format["Something went wrong: %1",_msg]]] call ExileClient_gui_toaster_addTemplateToast;
	};
};

ExileClient_GRGApps_network_updateLevel7TimeRemainingResponse = {
	params["_level7TimeRemaining"];
	GRG_level7timeRemaining = _level7TimeRemaining;  
	//private _m = format["GRG_level7timeRemaining updated to %1",GRG_level7timeRemaining];
	//diag_log _m;
	//systemChat _m;
};

// Not used presently
/*
ExileClient_GRGApps_network_getLevel7TimeRemainingResponse = {
	params["_level7TimeRemaining"];
	GRG_level7timeRemaining = _level7TimeRemaining;  
	//private _m = format["GRG_level7timeRemaining updated to %1",GRG_level7timeRemaining];
	//diag_log _m;
	//systemChat _m;
};
*/

ExileClient_GRGApps_network_purchaseAirdropResponse = {
	params["_success","_airdropType"];
	if (_success) then 
	{
		["SuccessTitleAndText", ["Airdrop inbound", format["Your %1 will be dropped in shortly",_airdropType]]] call ExileClient_gui_toaster_addTemplateToast;
	} else {
		["ErrorTitleAndText", ["ERROR", format["Something went wrong: %1",_msg]]] call ExileClient_gui_toaster_addTemplateToast;
	};
};

ExileClient_GRGApps_network_respectToTabsResponse = {
	params["_success"];
	if (_success) then 
	{
		["SuccessTitleAndText", ["Success", format["Respect was convered to Tabs"]]] call ExileClient_gui_toaster_addTemplateToast;
	} else {
		["ErrorTitleAndText", ["ERROR", format["Something went wrong: %1",_msg]]] call ExileClient_gui_toaster_addTemplateToast;
	};
};
