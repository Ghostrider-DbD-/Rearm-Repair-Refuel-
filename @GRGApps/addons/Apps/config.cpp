/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

class CfgPatches {
	class GRG_Apps {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"GMSCore"};
	};
};
class GRG_Apps_Build {
	version = "0.01";
	build = "1";
	buildDate = "4-13-19";
}
class CfgFunctions {
	class GRGApps {
		class startup {
			file = "Apps\init";
			class init {
				postInit = 1;
			};
		};
		class functions {
			file ="Apps\Compiles\Functions";
			class updatePlayerTabs {};
			class updatePlayerRespect {};
			class airdrops {};
		};
	};
};
