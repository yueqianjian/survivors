extends Node

@export var experience_manager: Node
@export var ability_pool: Array[AbilityUpgrade]

var current_upgrades = {
	
}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(new_level: int):
	var chosen_upgrade = ability_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
	
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
		
	print(current_upgrades)
