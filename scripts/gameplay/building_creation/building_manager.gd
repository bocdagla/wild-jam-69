class_name BuildingManager;
extends Node;

#region Scene imports
const ARCHERY = preload("res://prefabs/gameplay/buildings/archery.tscn");
const ARCHER_TOWER = preload("res://prefabs/gameplay/buildings/archer_tower.tscn");
const BARRACS = preload("res://prefabs/gameplay/buildings/barracs.tscn");
const CASTLE = preload("res://prefabs/gameplay/buildings/castle.tscn");
const FARM = preload("res://prefabs/gameplay/buildings/farm.tscn");
const FORGE = preload("res://prefabs/gameplay/buildings/forge.tscn");
const HOUSE = preload("res://prefabs/gameplay/buildings/house.tscn");
const HOUSE_BIG = preload("res://prefabs/gameplay/buildings/house_big.tscn");
const LUMBERMILL = preload("res://prefabs/gameplay/buildings/lumbermill.tscn");
const MAGE_TOWER = preload("res://prefabs/gameplay/buildings/mage_tower.tscn");
const MARKET = preload("res://prefabs/gameplay/buildings/market.tscn");
const MILL = preload("res://prefabs/gameplay/buildings/mill.tscn");
const MINE = preload("res://prefabs/gameplay/buildings/mine.tscn");
const QUARRY = preload("res://prefabs/gameplay/buildings/quarry.tscn");
const TAVERN = preload("res://prefabs/gameplay/buildings/tavern.tscn");
const TOWNHALL = preload("res://prefabs/gameplay/buildings/townhall.tscn");
const WATCHTOWER = preload("res://prefabs/gameplay/buildings/watchtower.tscn");
const SIEGE_TOWER = preload("res://prefabs/gameplay/buildings/siege_tower.tscn")
#endregion

@export var last_grid: GridRow;
var _left_last: bool = false;
@export var mid_grid: GridRow;
var _left_mid: bool = false;
@export var front_grid: GridRow;
var _left_front: bool = false;
	
#region Building functions

func build_archery():
	_build_mid(ARCHERY);

func build_archer_tower():
	_build_last(ARCHER_TOWER);

func build_barracs():
	_build_mid(BARRACS);

func build_castle():
	_build_last(CASTLE);

func build_farm():
	_build_front(FARM);

func build_forge():
	_build_mid(FORGE);

func build_house():
	_build_front(HOUSE);

func build_house_big():
	_build_mid(HOUSE_BIG);

func build_lumbermill():
	_build_front(LUMBERMILL);

func build_mage_tower():
	_build_last(MAGE_TOWER);

func build_market():
	_build_mid(MARKET);

func build_mill():
	_build_front(MILL);

func build_mine():
	_build_front(MINE);

func build_quarry():
	_build_front(QUARRY);

func build_tavern():
	_build_mid(TAVERN);

func build_townhall():
	_build_last(TOWNHALL);
	
func build_siege_tower():
	_build_last(SIEGE_TOWER);

func build_watchtower():
	_build_last(WATCHTOWER);

#endregion

func _build_last(building: PackedScene) -> void:
	if _left_last:
		last_grid.add_building_left(building);
	else:
		last_grid.add_building_right(building);
	_left_last = !_left_last;

func _build_mid(building: PackedScene) -> void:
	if _left_mid:
		mid_grid.add_building_left(building);
	else:
		mid_grid.add_building_right(building);
	_left_mid = !_left_mid;
	
func _build_front(building: PackedScene) -> void:
	if _left_front:
		front_grid.add_building_left(building);
	else:
		front_grid.add_building_right(building);
	_left_front = !_left_front;


func add_building_left():
	pass # Replace with function body.
