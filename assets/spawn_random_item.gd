extends Node2D

var items := [preload("gem.tscn"), preload("health_pack.tscn")]

func _ready():
	get_node("Timer").timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var random_scene: PackedScene = items.pick_random()
	var random_item := random_scene.instantiate()
	add_child(random_item)

	var view_port := get_viewport_rect().size
	var random_position := Vector2(0, 0)
	random_position.x = randf_range(0, view_port.x)
	random_position.y = randf_range(0, view_port.y)
	
	random_item.position = random_position