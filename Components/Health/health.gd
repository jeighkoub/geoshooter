extends Node
class_name Health

var max_health
var curr_health

signal health_depleted
signal health_damaged(amount)
signal health_healed(amount)

func setup(maxh, currh):
	max_health = maxh
	curr_health = clamp(currh, 0, max_health)

func damage_health(amount):
	curr_health -= abs(amount)
	health_damaged.emit(amount)
	if curr_health <= 0:
		curr_health = 0
		health_depleted.emit()

func heal_health(amount):
	curr_health += abs(amount)
	health_healed.emit(amount)
	if curr_health > max_health:
		curr_health = max_health#avoid potential min() overhead

func set_curr_health(value):
	curr_health = clamp(value, 0, max_health)
