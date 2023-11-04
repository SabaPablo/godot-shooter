class_name Player
extends CharacterBody2D
const bullets_load = 12
var speed = 400
var Bullet = preload("res://Scenes/bullet.tscn")
var shoot_time = false
var reload_time = false
var bullets = bullets_load
var sac_bullets = 4

func _input(event):
	if !shoot_time && !reload_time && Input.is_action_pressed("shoot") and event is InputEventMouseButton:
		if(bullets > 0 ):
			shoot(event)
		else:
			$AudioEmptyGun.play()
	if !shoot_time && !reload_time && sac_bullets > 0 && Input.is_action_pressed("reload"):
		var bull = min(sac_bullets + bullets, bullets_load)
		if(sac_bullets + bullets < bullets_load):
			sac_bullets = 0
		else:
			sac_bullets -= bullets_load - bullets
		reload(event, bull)
	
func _physics_process(delta):
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * speed
	if(shoot_time or reload_time):
		pass
	elif (velocity.x + velocity.y == 0):
		$AnimatedSprite2D.play("hand_gun_idle")
	else:
		$AnimatedSprite2D.play("hand_gun_move")
	rotation = (get_global_mouse_position() -global_position).normalized().angle()
	move_and_slide()


func shoot(event):
	var shoot = Bullet.instantiate()
	shoot.direction = (get_global_mouse_position() - $GunPosition.global_position).normalized()
	shoot.global_position = $EndGun.global_position
	get_parent().add_child(shoot)
	shoot_time = true
	$AnimatedSprite2D.play("hand_gun_shoot")
	$shootTime.start()
	$MuzzleFlash01.visible = true
	$lightgun.start()
	bullets -=1
	$AudioShoot.play()


func reload(event, bulls):
	print("reload")
	reload_time = true
	bullets = bulls
	$AnimatedSprite2D.play("hand_gun_reload")
	$AudioReload.play()
	$reloadgun.start()

func _on_shoot_time_timeout():
	shoot_time = false


func _on_lightgun_timeout():
	$MuzzleFlash01.visible = false


func _on_reloadgun_timeout():
	reload_time = false

func plus_bullets():
	sac_bullets += 4
