extends Node

const SPAWN_RADIUS = 330

@export var basic_enemy_scene: PackedScene


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var random_diretion = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_diretion * SPAWN_RADIUS)
	var enemy = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
