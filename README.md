# Rearm-Repair-Refuel-
A script that opens a dialog through which you can pay to rearm, repair and refuel. 
Supports Exile. 
Supports dynamic loadouts

Installation:
1. serverside changes and updates 
   Open @GRGApps\Addons\
   Make a .pbo of the Apps folder
   Copy @GRGApps into the root directory of your server
   Download GMSCore from my github
   Open @GRGCore\addons
   Make a .PBO of the GMSCore folder
   Copy @GMSCore to the root directory of your server
   Add @GMSCore;GRGAppse; to "-servermod=..."

2. Mission updates
  Copy the addons and xm8apps folders into your mission or merge their contents what what is already there.
  Merge the contents of the init.sqf, description.ext and config.cpp provided with what you have already.
  make a .pbo and fire it up.
  
 3. Configuration: 
    There is some ability to select the objects that are used as rearm or refuel stations
    Open addons\RRR_scripts\RRR_Config.cpp
    Adjust configs to your liking.
    
    * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
