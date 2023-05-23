extends Node

@export var end_screen_sence: PackedScene


func _ready():
	$%Player.health_component.died.connect(on_player_died)


func on_player_died():
	var end_screen_sence_instance = end_screen_sence.instantiate()
	add_child(end_screen_sence_instance)
	end_screen_sence_instance.set_defeat()
