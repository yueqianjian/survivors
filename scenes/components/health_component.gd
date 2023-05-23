extends Node

class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
var current_health: float


func _ready():
	current_health = max_health


func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	health_changed.emit()
	Callable(checkDeath).call_deferred()
	

func checkDeath():
	if current_health == 0:
		died.emit()
		owner.queue_free()


func get_health_percent():
	return min(current_health / max_health, 1)
