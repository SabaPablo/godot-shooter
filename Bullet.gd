extends Area2D

var direction : Vector2
var speed := 2000

func _ready():
	rotation = direction.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += speed * direction * delta 


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.die()
		queue_free()
	if body.is_in_group("obstacle"):
		queue_free()


func _on_timer_timeout():
	queue_free()
