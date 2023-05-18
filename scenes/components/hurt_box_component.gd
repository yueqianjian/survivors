extends Area2D

@export var health_copment: Node


func _on_area_entered(area: Area2D):
	if health_copment == null:
		return
		
	if area is HitBoxComponent:
		health_copment.damage(area.damage)
