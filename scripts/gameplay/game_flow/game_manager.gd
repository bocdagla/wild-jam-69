class_name GameManager;
extends Node

@export var first_attack_turn := 10;
@export var first_attack_defense := 10;
@export var second_attack_turn := 20;
@export var second_attack_defense := 10;
@export var last_attack_turn := 30;
@export var last_attack_defense := 10;

@onready var build_ui: CanvasLayer = %BuildUI
@onready var main_camera: Camera3D = %MainCamera
@onready var turn_manager: TurnManager = %TurnManager
@onready var resource_manager: ResourceManager = %ResourceManager
@onready var game_over_ui: CanvasLayer = %GameOverUI

enum GAME_STATE { STARTING, TUTORIAL, PLAYING, FIRST_ATTACK, SECOND_ATTACK, FINAL_ATTACK, GAMEOVER };
var state: GAME_STATE = GAME_STATE.STARTING;

func _ready() -> void:
	turn_manager.turn_started.connect(_on_turn_start);
	call_deferred("_on_tutorial_finished");

func _change_state(new_state: GAME_STATE):
	match new_state:
		GAME_STATE.STARTING:
			game_over_ui.visible = false;
			build_ui.visible = false;
			pass

		GAME_STATE.TUTORIAL:
			print("tutorial");
			game_over_ui.visible = false;
			build_ui.visible = false;
			pass

		GAME_STATE.PLAYING:
			game_over_ui.visible = false;
			build_ui.visible = true;
			pass

		GAME_STATE.FIRST_ATTACK:
			print("Firsst Attack");
			game_over_ui.visible = false;
			build_ui.visible = false;
			_change_state(GAME_STATE.GAMEOVER);
			pass

		GAME_STATE.SECOND_ATTACK:
			print("Second Attack");
			game_over_ui.visible = false;
			build_ui.visible = false;
			_change_state(GAME_STATE.GAMEOVER);
			pass

		GAME_STATE.FINAL_ATTACK:
			print("Final Attack");
			game_over_ui.visible = false;
			build_ui.visible = false;
			_change_state(GAME_STATE.GAMEOVER);
			pass

		GAME_STATE.GAMEOVER:
			build_ui.visible = false;
			game_over_ui.visible = true;
			print("Game Over");
			pass

func _on_tutorial_finished():
	_change_state(GAME_STATE.PLAYING);

func _on_turn_start(turn: int):
	match turn:
		first_attack_turn:
			_change_state(GAME_STATE.FIRST_ATTACK);
		second_attack_turn:
			_change_state(GAME_STATE.SECOND_ATTACK);
		last_attack_turn:
			_change_state(GAME_STATE.FINAL_ATTACK)

func _on_restart_pressed():
	get_tree().reload_current_scene();

