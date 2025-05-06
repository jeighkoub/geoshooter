extends Area2D
class_name gravity_well

@export var G: float # this G = real G * self.mass
@export var G_max: float = 3000
@export var G_min: float = 100
var radius: float
var decay: float

func _ready() -> void:
	var col_shape = $CollisionShape2D
	if col_shape.shape is CircleShape2D:
		radius = col_shape.shape.radius 
		print(radius)
		decay = G / radius


func calculate_gravity(body: PhysicsBody2D) -> Vector2:
	var r2 = self.global_position.distance_squared_to(body.global_position)
	var r = self.global_position.distance_to(body.global_position)
	r = max(r,100.0)
	
	#1/r^2
	var g_mag = G / ((r+1000)**2)
	
	#1/r
	#var g_mag = G / r
	
	# linear 0 to G
	#var g_mag = G - sqrt(r2) * decay
	
	g_mag = clampf(g_mag, G_min, G_max)
	return  g_mag * body.global_position.direction_to(self.global_position)


	
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is PhysicsBody2D:
			body.velocity += delta * calculate_gravity(body)
	
