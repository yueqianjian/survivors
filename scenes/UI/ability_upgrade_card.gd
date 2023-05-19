extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var discription_label: Label = $%DiscriptionLabel


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	discription_label.text = upgrade.description


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("click_left"):
		selected.emit()
