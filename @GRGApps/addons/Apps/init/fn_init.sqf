/*
	by Ghostrider [GRG]
	Last Modified 3/14/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
if !(isNil "GMS_AppsLoaded") exitWith {diag_log format["GMS_Apps already loaded",diag_tickTime];};
private _build = getText(configFile >> "GRG_Apps_Build" >> "build");
private _ver = getText(configFile >> "GRG_Apps_Build" >> "version");
private _date = getText(configFile >> "GRG_Apps_Build" >> "buildDate");
GMS_Apps_Loaded = true;
call compileFinal preprocessFileLineNumbers "Apps\Compiles\Functions\serverNetworkedFunctions.sqf";
diag_log format["GMS_Apps Version %1 Build %2 Dated %3 Loaded",_ver,_build,_date];