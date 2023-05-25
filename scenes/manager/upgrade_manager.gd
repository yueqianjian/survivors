extends Node

@export var experience_manager: Node
@export var upgrade_screen_sence: PackedScene
@export var upgrade_pool: Array[AbilityUpgrade]

var current_upgrades = {
	
}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	var quantity = current_upgrades[upgrade.id]["quantity"]
	if quantity == upgrade.max_quantity:
		upgrade_pool = upgrade_pool.filter(
			func (e):
				return e.id != upgrade.id
		)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	print(current_upgrades)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filter_upgrades = upgrade_pool.duplicate()
	for i in 2:
		if filter_upgrades.is_empty():
			break
		
		var chosen_upgrade = filter_upgrades.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		filter_upgrades = filter_upgrades.filter(
			func(e):
				return e.id != chosen_upgrade.id
		)
	
	return chosen_upgrades


func on_upgrades_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(new_level: int):
	var chosen_upgrades = pick_upgrades()
	if chosen_upgrades.size() == 0:
		return
	
	var upgrade_sceen_instance = upgrade_screen_sence.instantiate()
	add_child(upgrade_sceen_instance)
	upgrade_sceen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_sceen_instance.upgrades_selected.connect(on_upgrades_selected)
	
