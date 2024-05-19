class_name BuyBuildingButtonContent;
extends MarginContainer;

@onready var _gold_label: Label = $VBoxContainer/Label/GoldLabel;
@onready var _defense_icon: TextureRect = $VBoxContainer/Label/DefenseIcon;
@onready var _defense_label: Label = $VBoxContainer/Label/DefenseLabel;
@onready var benefit = $VBoxContainer/Label/Benefit
@onready var benefit_gold_icon = $VBoxContainer/Label/BenefitGoldIcon
@onready var benefit_gold = $VBoxContainer/Label/BenefitGold
@onready var benefit_separator = $VBoxContainer/Label/BenefitSeparator
@onready var benefit_defense_icon = $VBoxContainer/Label/BenefitDefenseIcon
@onready var benefit_defense = $VBoxContainer/Label/BenefitDefense
@onready var benefit_turn = $VBoxContainer/Label/BenefitTurn
@onready var benefit_turn_separator = $VBoxContainer/Label/BenefitTurnSeparator
@onready var benefit_turn_gold_icon = $VBoxContainer/Label/BenefitTurnGoldIcon
@onready var benefit_turn_gold = $VBoxContainer/Label/BenefitTurnGold
@onready var benefit_turn_defense_icon = $VBoxContainer/Label/BenefitTurnDefenseIcon
@onready var benefit_turn_defense = $VBoxContainer/Label/BenefitTurnDefense


func setup(buildin_record: BuildingRecord):
	_gold_label.text = str(buildin_record.gold_cost);
	_defense_label.text = str(buildin_record.defense_cost);
	if buildin_record.defense_cost == 0:
		_defense_label.visible = false;
		_defense_icon.visible = false;

	benefit_gold.text = str(buildin_record.gold_gain);
	benefit_defense.text = str(buildin_record.defense_gain);
	if buildin_record.gold_gain == 0 and buildin_record.defense_gain == 0:
		benefit_separator.visible = false;
		benefit.visible = false;
	if buildin_record.gold_gain == 0:
		benefit_gold.visible = false;
		benefit_gold_icon.visible = false;
	if buildin_record.defense_gain == 0:
		benefit_defense.visible = false;
		benefit_defense_icon.visible = false;
		
	benefit_turn_gold.text = str(buildin_record.turn_gold_gain);
	benefit_turn_defense.text = str(buildin_record.turn_defense_gain);
	if buildin_record.turn_gold_gain == 0 and buildin_record.turn_defense_gain == 0:
		benefit_turn_separator.visible = false;
		benefit_turn.visible = false;
	if buildin_record.turn_gold_gain == 0:
		benefit_turn_gold.visible = false;
		benefit_turn_gold_icon.visible = false;
	if buildin_record.turn_defense_gain == 0:
		benefit_turn_defense.visible = false;
		benefit_turn_defense_icon.visible = false;
		
	

