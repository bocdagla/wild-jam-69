extends Node

var buildings: Dictionary;

func _ready() -> void:
	for path in get_resources_from_folder("res://resources/buildings/"):
		var building_record = ResourceLoader.load(path) as BuildingRecord;
		buildings[building_record.id] = building_record;

func get_resources_from_folder(path):
	var files = []
	var dir = DirAccess.open(path);

	for file_name in dir.get_files():
		if '.tres.remap' in file_name:
			file_name = file_name.trim_suffix('.remap');
		files.append(dir.get_current_dir() + "/" + file_name);
	return files;
