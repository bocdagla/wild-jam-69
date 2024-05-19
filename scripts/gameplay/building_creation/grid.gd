class_name GridRow
extends Node3D

@export var cell_size: float = 2.;
@export var x_offset: float = cell_size;
@export var max_builing_ammount: int = 10;
@export var use_center: bool = false;

var _current_buildings_built = 0;
var right_ammount: int = 1;
var left_ammount: int = 1;
var _left: bool = false;

func can_build() -> bool:
	return _current_buildings_built < max_builing_ammount;

func add(building: PackedScene) -> Building:
	var ins: Building;
	if use_center:
		ins = add_building_center(building);
	elif _left:
		ins = add_building_left(building);
	else:
		ins = add_building_right(building);
	use_center = false;
	_left = !_left;
	return ins;

func add_building_right(building: PackedScene) -> Building:
	var build = _add_building(x_offset + right_ammount * (cell_size/2), building); # queremos poner el edificio en el centro
	right_ammount += 1;
	return build;

func add_building_left(building: PackedScene) -> Building:
	var build = _add_building(-x_offset + -left_ammount * (cell_size/2), building); # queremos poner el edificio en el centro
	left_ammount += 1;
	return build;

func add_building_center(building: PackedScene) -> Building:
	var build = _add_building(0, building); # queremos poner el edificio en el centro
	return build;

func _add_building(pos: float, building: PackedScene) -> Building:
	var inst = building.instantiate() as Building;
	add_child(inst);
	inst.position = Vector3(pos, 0, 0);
	inst.start_build();
	_current_buildings_built += 1;
	return inst;
