extends CharacterBody2D
class_name Player

@export var acceleration_magnitude: float
@export var friction: float



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	#var direction: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if Input.is_action_pressed("gas"):
		velocity += Vector2.RIGHT.rotated(self.global_rotation) * acceleration_magnitude * delta
	velocity = velocity.move_toward(Vector2.ZERO, delta*friction)
	move_and_slide()
