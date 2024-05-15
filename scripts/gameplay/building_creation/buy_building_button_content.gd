class_name BuyBuildingButtonContent;
extends MarginContainer;

@onready var _gold_label: Label = $VBoxContainer/Label/GoldLabel;
@onready var _defense_icon: TextureRect = $VBoxContainer/Label/DefenseIcon;
@onready var _defense_label: Label = $VBoxContainer/Label/DefenseLabel;

func setup(buildin_record: BuildingRecord):
	_gold_label.text = str(buildin_record.gold_cost);
	_defense_label.text = str(buildin_record.defense_cost);
	if buildin_record.defense_cost == 0:
		_defense_label.visible = false;
		_defense_icon.visible = false;
