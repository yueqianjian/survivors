extends Node

signal arena_difficulty_increased(arena_difficulty: int)

const DIFFICULTY_INTERVAL = 5

@export var end_screen_sence: PackedScene

@onready var timer: Timer = $Timer

var arena_difficulty = 1


func _process(delta):
	var next_target_time = timer.wait_time - (arena_difficulty * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_target_time:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func _on_timer_timeout():
	var end_screen_instance = end_screen_sence.instantiate()
	add_child(end_screen_instance)
