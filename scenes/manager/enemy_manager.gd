extends Node

const SPAWN_RADIUS = 330

@export var basic_enemy_scene: PackedScene
@export var arena_timer_manager: Node

@onready var timer: Timer = $Timer

var base_spawn_time = 0


func _ready():
	base_spawn_time = timer.wait_time
	arena_timer_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	
	var random_diretion = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Vector2.ZERO
	for i in 4:
		spawn_position = player.global_position + (random_diretion * SPAWN_RADIUS)
		var query = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query)
		if result.is_empty():
			return spawn_position
		else:
			random_diretion = random_diretion.rotated(deg_to_rad(90))
	
	return spawn_position


func _on_timer_timeout():
	timer.start()
	var spawn_position = get_spawn_position()
	var enemy = basic_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (0.1 / (60 / 5)) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
