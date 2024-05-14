class_name GridRow
extends Node3D

@export var cell_size: float = 2.;

var right_ammount: int = 0;
var left_ammount: int = 0;


func add_building_right(building: PackedScene) -> void:
	_add_building(right_ammount * (cell_size/2), building); # queremos poner el edificio en el centro
	
	if right_ammount == 0:
		left_ammount += 1; 
		
	right_ammount += 1;
	
func add_building_left(building: PackedScene) -> void:
	_add_building(-left_ammount * (cell_size/2), building); # queremos poner el edificio en el centro
	
	if left_ammount == 0:
		right_ammount += 1;
		
	left_ammount += 1; 

func _add_building(position: float, building: PackedScene):
	var inst = building.instantiate() as Node3D;
	add_child(inst);
	inst.position = Vector3(position, 0, 0);
