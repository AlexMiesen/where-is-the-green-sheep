extends Sprite2D

var velocity := Vector2(0, 0)
var max_speed := 600.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector2(0,0)
	
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction.length() > 1.0:
		direction = direction.normalized()
	
	velocity = direction * max_speed
	position += velocity * delta
	if direction.length() > 0.0:
		rotation = velocity.angle()
