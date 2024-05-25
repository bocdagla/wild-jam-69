class_name Building;
extends Node3D;

@export var building_record: BuildingRecord;
@export var _main_structure: Node3D;

@onready var building_stage_a_2: Node3D = $building_stage_A2;
@onready var building_stage_b_2: Node3D = $building_stage_B2;
@onready var building_stage_c_2: Node3D = $building_stage_C2;

var current_build_turn: int = 0;
var build_fase: int = 0;
var built: bool = false;

signal send_expected_gold_next_turn(gold: int, defense: int);
signal finished_building();
signal send_resources(gold: int, defense: int);

func start_build() -> void:
	current_build_turn = 0;
	built = false;
	build_fase = 0;
	building_stage_a_2.visible = true;
	building_stage_b_2.visible = false;
	building_stage_c_2.visible = false;
	_main_structure.visible = false;
	if current_build_turn == building_record.build_turns - 1:
		send_expected_gold_next_turn.emit(building_record.gold_gain, building_record.defense_gain);

func advance_turn(_turn: int) -> void:
	if not built:
		_build_fase_advance_turn();
	else:
		send_resources.emit(building_record.turn_gold_gain, building_record.turn_defense_gain);
		send_expected_gold_next_turn.emit(building_record.turn_gold_gain, building_record.turn_defense_gain);

func _build_fase_advance_turn() -> void:
	current_build_turn += 1;
	if current_build_turn == building_record.build_turns - 1:
		send_expected_gold_next_turn.emit(building_record.gold_gain, building_record.defense_gain);
	match build_fase:
		0:
			if current_build_turn >= building_record.build_turns:
				finish_building();
			elif current_build_turn >= (building_record.build_turns/3)*2:
				build_fase2();
			elif current_build_turn >= (building_record.build_turns/3):
				build_fase1();
		1:
			if current_build_turn >= building_record.build_turns:
				finish_building();
			elif current_build_turn >= (building_record.build_turns/3)*2:
				build_fase2();
		2:
			if current_build_turn >= building_record.build_turns:
				finish_building();

func build_fase1() -> void:
	build_fase = 1;
	building_stage_a_2.visible = false;
	building_stage_b_2.visible = true;
	building_stage_c_2.visible = false;
	_main_structure.visible = false;

func build_fase2() -> void:
	building_stage_a_2.visible = false;
	building_stage_b_2.visible = false;
	building_stage_c_2.visible = true;
	_main_structure.visible = false;
	build_fase = 2;

func finish_building():
	building_stage_a_2.visible = false;
	building_stage_b_2.visible = false;
	building_stage_c_2.visible = false;
	_main_structure.visible = true;
	build_fase = 3;
	built = true;
	send_resources.emit(building_record.gold_gain, building_record.defense_gain);
	send_expected_gold_next_turn.emit(building_record.turn_gold_gain, building_record.turn_defense_gain);
	finished_building.emit();
