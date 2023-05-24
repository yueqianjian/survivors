extends Node

@export var axe_ability_sence: PackedScene
@export var damage = 10


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var foreground = get_tree().get_first_node_in_group("foreground_layer")
	if foreground == null:
		return
	
	var axe_ability_instance = axe_ability_sence.instantiate() as Node2D
	foreground.add_child(axe_ability_instance)
	axe_ability_instance.global_position = player.global_position
	axe_ability_instance.hit_box_component.damage = damage
