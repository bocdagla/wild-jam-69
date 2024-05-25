class_name GameManager;
extends Node

@onready var event_manager: EventManager = $"../EventManager"
@onready var win: AudioStreamPlayer = $"../win"
@onready var loose: AudioStreamPlayer = $"../loose"
@onready var main_music: AudioStreamPlayer = $"../main_music"


@onready var main_camera: Camera3D = %MainCamera
@onready var game_over_ui: EventWindow = %GameOverUI
@onready var victory_ui: EventWindow = %VictoryUI
@onready var event_ui: EventWindow = %EventUI
@onready var build_ui: CanvasLayer = %BuildUI
@onready var tutorial: EventWindow = %Tutorial


enum GAME_STATE { STARTING, TUTORIAL, PLAYING, CRUCIAL_EVENT_HAPPENING, FINAL_EVENT_HAPPENING, GAMEOVER, VICTORY };
var state: GAME_STATE = GAME_STATE.STARTING;

func _ready() -> void:
	call_deferred("_on_game_start");
	event_manager.crucial_event_started.connect(_on_crucial_event_started);
	event_manager.final_event_started.connect(_on_final_event_started);
	event_manager.crucial_event_resolved.connect(_on_crucial_event_resolved);

func _change_state(new_state: GAME_STATE):
	match new_state:
		GAME_STATE.STARTING:
			tutorial.hide();
			game_over_ui.visible = false;
			victory_ui.visible = false;
			build_ui.visible = false;
			event_ui.visible = false;
			pass

		GAME_STATE.TUTORIAL:
			tutorial.show();
			game_over_ui.visible = false;
			victory_ui.visible = false;
			build_ui.visible = false;
			event_ui.visible = false;
			pass

		GAME_STATE.PLAYING:
			tutorial.hide();
			game_over_ui.visible = false;
			victory_ui.visible = false;
			build_ui.visible = true;
			event_ui.visible = false;
			pass

		GAME_STATE.CRUCIAL_EVENT_HAPPENING:
			print("CRUCIAL EVENT");
			tutorial.hide();
			game_over_ui.visible = false;
			victory_ui.visible = false;
			build_ui.visible = false;
			event_ui.visible = true;
			pass

		GAME_STATE.FINAL_EVENT_HAPPENING:
			print("FINAL EVENT");
			tutorial.hide();
			game_over_ui.visible = false;
			victory_ui.visible = false;
			build_ui.visible = false;
			event_ui.visible = true;
			pass

		GAME_STATE.GAMEOVER:
			main_music.stop();
			loose.play();
			tutorial.hide();
			build_ui.visible = false;
			game_over_ui.visible = true;
			victory_ui.visible = false;
			event_ui.visible = false;
			print("Game Over");
			pass

		GAME_STATE.VICTORY:
			main_music.stop();
			win.play();
			tutorial.hide();
			build_ui.visible = false;
			game_over_ui.visible = false;
			victory_ui.visible = true;
			event_ui.visible = false;
			print("Victory");
			pass
	state = new_state;

func _on_game_start():
	_change_state(GAME_STATE.TUTORIAL);

func _on_tutorial_finished():
	_change_state(GAME_STATE.PLAYING);

func _on_restart_pressed():
	get_tree().reload_current_scene();

func _on_crucial_event_started() -> void:
	_change_state(GAME_STATE.CRUCIAL_EVENT_HAPPENING);

func _on_final_event_started() -> void:
	_change_state(GAME_STATE.FINAL_EVENT_HAPPENING);


func _on_crucial_event_resolved(success: bool) -> void:
	match state:
		GAME_STATE.CRUCIAL_EVENT_HAPPENING:
			if success:
				_change_state(GAME_STATE.PLAYING);
			else:
				_change_state(GAME_STATE.GAMEOVER);
		GAME_STATE.FINAL_EVENT_HAPPENING:
			if success:
				_change_state(GAME_STATE.VICTORY);
			else:
				_change_state(GAME_STATE.GAMEOVER);
