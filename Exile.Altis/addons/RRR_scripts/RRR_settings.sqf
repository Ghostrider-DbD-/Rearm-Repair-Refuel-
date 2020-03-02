/*
	Configurations for Refueling
*/

RRR_disableDefaultRefuel = true;
RRR_fuelSourceTypes = ["Land_FuelStation_Feed_F","Land_fs_feed_F","StorageBladder_01_fuel_sand_F","StorageBladder_01_fuel_sand_F","pod_heli_transport_04_fuel_f"];  // classnames of fuel sources from which fuel cans can be refilled.
RRR_fuelSourceSearchDistanceLand = 25; // distance in meters to search for fuel containers for each iteration
RRR_fuelSourceSearchDistanceAir = 40;
RRR_fuelSourceSearchDistanceShip = 60;

RRR_canRefuelFromDriverSeat = ["Car","Armored","Air","Ship","ExileChoppers","ExileCars","ExileBoats"];
RRR_canRefuelFromExterior = ["Car","Armored","Air","Ship","ExileChoppers","ExileCars","ExileBoats"];
RRR_vehicleRefuelTime = 20;

RRR_fuelPricePerLiter = 2;

// Defaults (when the price per liter == 0)
RRR_refuelPriceCars = 25;
RRR_refuelPriceTanks = 50; 
RRR_refuelPriceAir = 100;
RRR_refuelPriceShip = 60; 


/*
	Configuration for Repair
*/

RRR_repairStationTypes = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F","Land_CarService_F","RepairDepot_01_Green_F",  //  "Land_FuelStation_02_workshop_F"
						"Land_A_FuelStation_Shed","Land_repair_center","Land_Mil_Repair_center_EP1","Land_Ind_Garage01_EP1"]; // service point classes (can be house, vehicle and unit classes)];

RRR_repairStationSearchDistanceLand = 25;
RRR_repairStationSearchDistanceAir = 40;
RRR_repairStationSearchDistanceShip = 60;

RRR_canRepairFromDriverSeat = ["Ship","ExileBoats"];
RRR_canRepairFromExterior = ["Car","Armored","Air","Ship","ExileChoppers","ExileCars","ExileBoats"];
//RRR_vehicleRepairTime = 15;  // Not used 10/6/19
RRR_vehicleRepairTimePerHitpoint = 1;

RRR_repairPriceCars = 400;
RRR_repairPriceTanks = 500; 
RRR_repairPriceAir = 500;
RRR_repairPriceShip = 400; 

RRR_servicePointTypes = [];
{RRR_servicePointTypes pushBackUnique _x} forEach (RRR_repairStationTypes + RRR_fuelSourceTypes);

RRR_RearmStationSearchDistanceLand = 15;
RRR_RearmStationSearchDistanceAir = 30;
RRR_RearmStationSearchDistanceShip = 60;

RRR_RearmStationSearchDistanceNotifications = selectMax[RRR_RearmStationSearchDistanceLand,RRR_RearmStationSearchDistanceAir,RRR_RearmStationSearchDistanceShip];

RRR_rearmMode = "";  // Set this to "" to calculate price per mag. or "PerVehicle" to use the default prices listed below
RRR_MaxMagsToLoad = -1;
RRR_defaultRearmMagazinePrice = 25;
RRR_RearmPriceCars = 450;
RRR_RearmPriceApcs = 550;
RRR_RearmPriceTanks = 650; 
RRR_RearmPriceAir = 700;
RRR_RearmPriceShips = 450; 

RRR_canRearmFromDriverSeat = ["Ship","ExileBoats"];
RRR_canRearmFromExterior = ["Car","Armored","Air","Ship","ExileChoppers","ExileCars","ExileBoats"];
//RRR_vehicleRearmTime = 15;  // Not used 10/6/19
RRR_vehicleRearmTimePerTurret = 2.5;

RRR_spSearchDistanceLand = 25;
RRR_spSearchDistanceAir = 40;
RRR_spSearchDistanceShip = 60;
RRR_canServiceFromDriverSeat = ["Ship","ExileBoats"];
RRR_canServiceFromExterior = ["Car","Armored","Air","Ship","ExileChoppers","ExileCars","ExileBoats"];
RRR_servicePointNearestFlag = 200;

RRR_debugMode = false;
