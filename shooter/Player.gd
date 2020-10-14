extends "res://shooter/Shooter.gd"

const BULLET = preload("res://bullet/Bullet.tscn")

#export (float) var lifetime = 3

func get_input():

	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
#	if Input.is_action_just_pressed("left_click"):
#		shoot()
#	if Input.is_action_just_pressed("right_click"):
#		obstacle()

	velocity = velocity.normalized() * speed

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if (event.position != position):
				var direction = (event.global_position - global_position).normalized()
				var bullet = BULLET.instance()
				get_parent().add_child(bullet)
				bullet.global_position = $Muzzle.global_position
				bullet.set_bullet_direction(direction)
				bullet.rotation_degrees = rotation_degrees
				
