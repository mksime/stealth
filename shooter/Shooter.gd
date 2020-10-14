extends KinematicBody2D

var velocity = Vector2()
export var speed: int = 200

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func get_input():
	pass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
