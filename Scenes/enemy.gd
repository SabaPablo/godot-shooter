extends CharacterBody2D

var player : Player
var speed = randf_range(100,400)
const drop_probability = 40

var Bullets = preload("res://Scenes/ammo.tscn")

func _ready():
	
	player = get_tree().get_first_node_in_group("myPlayer")
	$AnimatedSprite2D.play()
	$Timer.start(randf_range(5,30))

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		rotation = direction.angle()

func die():
	if(drop_probability > randi_range(0,100)):
		drop_bullets()
	queue_free()


func drop_bullets():
	var new_bullets = Bullets.instantiate()
	new_bullets.global_position = global_position
	$AudioJump.play()
	get_parent().add_child(new_bullets)
	

func _on_timer_timeout():
	print("arggggg")
	var random = randi_range(1,4)
	if(random == 1):
		$AudioZombie1.play()
	if(random == 2):
		$AudioZombie2.play()
	if(random == 3):
		$AudioZombie3.play()
	if(random == 4):
		$AudioZombie4.play()
	var wait = randf_range(5,30)
	print(wait)
	$Timer.start(wait)
