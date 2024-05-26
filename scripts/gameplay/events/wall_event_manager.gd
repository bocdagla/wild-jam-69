class_name WallEventManager
extends Node3D

@onready var resource_manager: ResourceManager = %ResourceManager
@onready var fence_stone: Node3D = $FenceStone
@onready var fence_wood: Node3D = $FenceWood
@onready var wall: Node3D = $Wall

@export var stonefence_threshold: int = 500
@export var woodfence_threshold: int = 5000
@export var wall_threshold: int = 20000

func _ready() -> void:
	fence_stone.hide()
	fence_wood.hide()
	wall.hide()
	resource_manager.value_changed.connect(_on_resource_value_changed)

func _on_resource_value_changed(_gold: int, defense: int) -> void:
	if defense >= wall_threshold:
		_show_wall()
	elif defense >= woodfence_threshold:
		_show_wood_fence()
	elif defense >= stonefence_threshold:
		_show_stone_fence()

func _show_wall() -> void:
	if wall.visible:
		return
	wall.show()
	_animate(wall)
	fence_wood.hide()
	fence_stone.hide()

func _show_wood_fence() -> void:
	if fence_wood.visible:
		return
	fence_wood.show()
	_animate(fence_wood)
	fence_stone.hide()
	wall.hide()

func _show_stone_fence() -> void:
	if fence_stone.visible:
		return
	fence_stone.show()
	_animate(fence_stone)
	fence_wood.hide()
	wall.hide()

func _animate(node: Node3D) -> void:
	var tween = node.create_tween()
	tween.tween_property(node, "position:y", 0, 1)
