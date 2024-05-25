@tool
class_name EventWindow;
extends CanvasLayer

@export_multiline var description_text: String:
	set(value):
		description_text = value;
		_description.text = value;
@export var button_text: String:
	set(value):
		_submit_event.text = value;
		button_text = value;

@export var _submit_event: Button
@export var _description: Label

signal submit_event;

func _ready() -> void:
	_submit_event.pressed.connect(_emit_submit_event);

func _emit_submit_event():
	submit_event.emit();
