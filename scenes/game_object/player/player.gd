extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_bar = $HealthBar
@onready var health_component = $HealthComponent
@onready var abilities = $Abilities

var number_colliding_bodies = 0


func _ready():
	health_component.health_changed.connect(on_health_changed)
	update_health_display()
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	
	health_component.damage(1)
	damage_interval_timer.start()
	print(health_component.current_health)


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func _on_hurt_box_area_body_entered(body):
	number_colliding_bodies += 1
	check_deal_damage()


func _on_hurt_box_area_body_exited(body):
	number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	update_health_display()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if not upgrade is Ability:
		return
	var ability = upgrade as Ability
	var ability_instance = (ability.ability_contorller_sence as PackedScene).instantiate()
	abilities.add_child(ability_instance)
