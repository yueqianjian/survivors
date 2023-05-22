extends Node

@export var experience_manager: Node
@export var upgrade_screen_sence: PackedScene
@export var ability_pool: Array[AbilityUpgrade]

var current_upgrades = {
	
}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(new_level: int):
	var chosen_upgrade = ability_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
	
	var upgrade_sceen_instance = upgrade_screen_sence.instantiate()
	add_child(upgrade_sceen_instance)
	upgrade_sceen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_sceen_instance.upgrades_selected.connect(on_upgrades_selected)
	

func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	print(current_upgrades)


func on_upgrades_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
