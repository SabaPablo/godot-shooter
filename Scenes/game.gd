extends Node2D

var Enemy = preload("res://Scenes/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", create_enemy)


func create_enemy():
	
	if(get_tree().get_nodes_in_group("enemy").size()<30):
		var new_enemy = Enemy.instantiate()
		new_enemy.global_position = Vector2(randf_range(0,2000), randf_range(-500,1000))
		add_child(new_enemy)
