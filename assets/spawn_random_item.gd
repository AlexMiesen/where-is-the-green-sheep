extends Node2D

var items := [preload("gem.tscn"), preload("health_pack.tscn")]
var spawned_items_count := 0

func _ready():
	get_node("Timer").timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var random_scene: PackedScene = items.pick_random()
	var random_item := random_scene.instantiate()
	
	if spawned_items_count < 6:
		spawned_items_count += 1
		add_child(random_item)
	
	random_item.tree_exited.connect(_lessen_number_of_spawned_items)


	var view_port := get_viewport_rect().size
	var random_position := Vector2(0, 0)
	random_position.x = randf_range(0, view_port.x)
	random_position.y = randf_range(0, view_port.y)
	
	random_item.position = random_position

func _lessen_number_of_spawned_items() -> void:
	spawned_items_count -= 1
