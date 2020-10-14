extends KinematicBody2D

const SPEED = 500

var velocity = Vector2()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.is_in_group('wall'):
		velocity = velocity.bounce(collision.normal)
		global_rotation = velocity.angle()
	elif collision and collision.collider.is_in_group('shooter'):
		collision.collider.queue_free()
		queue_free()

func set_bullet_direction(direction):
	velocity = direction * SPEED

func _on_LifeTime_timeout():
	queue_free()
