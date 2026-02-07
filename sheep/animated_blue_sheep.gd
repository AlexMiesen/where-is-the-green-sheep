extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

# var velocity := Vector2(0, 0) This doesn't need to be declared in CharacterBody2D because it already has a built in velocity property
var normal_speed := 600.0
var max_speed := normal_speed
var boost_speed := 1500.0

var steering_factor := 10.0
var health := 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("UI/HealthBar").value = health
	set_health(20)
	$Area2D.area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
		

	if direction.length() > 1.0:
		direction = direction.normalized()

	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()
		
	var desired_velocity := max_speed * direction
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	global_position += velocity * delta
	
	if direction.length() > 0.0:
		rotation = velocity.angle()
		sprite.play("walking")
	else:
		sprite.play("idle")

func _on_timer_timeout() -> void:
	max_speed = normal_speed

func set_health(new_health: int) -> void:
	health = new_health
	$UI/HealthBar.value = health

func _on_area_entered(area: Area2D) -> void:
	set_health(health + 20)
