extends Node

@export var vectory_screen: PackedScene

@onready var timer = $Timer

func get_time_elapsed():
	return timer.wait_time - timer.time_left


func _on_timer_timeout():
	var vectory_screen_instance = vectory_screen.instantiate()
	add_child(vectory_screen_instance)
